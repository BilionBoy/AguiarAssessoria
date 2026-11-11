class Rack::Attack
  # IP real do usuário. O req.ip padrão do Rack devolveria o IP do servidor do
  # Cloudflare; o remote_ip do Rails já descarta os proxies confiáveis
  # (config.action_dispatch.trusted_proxies em config/application.rb).
  class Request < ::Rack::Request
    def remote_ip
      @remote_ip ||= ActionDispatch::Request.new(env).remote_ip
    end

    def login?
      path == '/users/sign_in' && post?
    end

    # "Esqueceu a senha?" — cada pedido dispara um e-mail.
    def pedido_reset_senha?
      path == '/users/password' && post?
    end
  end

  # Usa o Rails.cache configurado no ambiente. Sem um cache_store dedicado
  # (Redis/solid_cache), cada worker Puma teria seu próprio contador em
  # memória e o limite real ficaria N vezes mais frouxo que o configurado
  # aqui — Rails.cache aponta pro backend real do ambiente (file_store em
  # produção), compartilhado entre processos.
  self.cache.store = Rails.cache

  throttle('logins/ip', limit: 5, period: 60.seconds) do |req|
    req.remote_ip if req.login?
  end

  throttle('logins/email', limit: 5, period: 60.seconds) do |req|
    req.params.dig('user', 'email')&.to_s&.downcase&.strip&.presence if req.login?
  end

  throttle('reset_senha/ip', limit: 5, period: 15.minutes) do |req|
    req.remote_ip if req.pedido_reset_senha?
  end

  throttle('reset_senha/email', limit: 3, period: 15.minutes) do |req|
    req.params.dig('user', 'email')&.to_s&.downcase&.strip&.presence if req.pedido_reset_senha?
  end

  # Throttle geral leve pra reduzir varredura/scraping sem incomodar uso normal.
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.remote_ip unless req.path.start_with?('/assets', '/layout/')
  end

  blocklist('block brute force logins') do |req|
    Rack::Attack::Allow2Ban.filter(req.remote_ip, maxretry: 10, findtime: 1.minute, bantime: 1.hour) do
      req.login?
    end
  end

  self.throttled_responder = lambda do |_request|
    [429, { 'content-type' => 'text/plain; charset=utf-8' }, ["Muitas tentativas. Aguarde e tente novamente.\n"]]
  end

  self.blocklisted_responder = lambda do |_request|
    [403, { 'content-type' => 'text/plain; charset=utf-8' },
     ["Acesso temporariamente bloqueado por excesso de tentativas.\n"]]
  end
end

ActiveSupport::Notifications.subscribe(/rack_attack/) do |_name, _start, _finish, _id, payload|
  req = payload[:request]
  next unless %i[throttle blocklist].include?(req.env['rack.attack.match_type'])

  Rails.logger.warn(
    "[Rack::Attack] #{req.env['rack.attack.match_type']} #{req.env['rack.attack.matched']} " \
    "ip=#{req.remote_ip} path=#{req.path}"
  )
end
