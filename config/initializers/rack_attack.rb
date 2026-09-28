class Rack::Attack
  # Usa o Rails.cache configurado no ambiente. Sem um cache_store dedicado
  # (Redis/solid_cache), cada worker Puma teria seu próprio contador em
  # memória e o limite real ficaria N vezes mais frouxo que o configurado
  # aqui — Rails.cache aponta pro backend real do ambiente (file_store em
  # produção), compartilhado entre processos.
  self.cache.store = Rails.cache

  throttle('logins/ip', limit: 5, period: 60.seconds) do |req|
    req.ip if req.path == '/users/sign_in' && req.post?
  end

  throttle('logins/email', limit: 5, period: 60.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.params.dig('user', 'email')&.to_s&.downcase&.presence
    end
  end

  # Throttle geral leve pra reduzir varredura/scraping sem incomodar uso normal.
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  blocklist('block brute force logins') do |req|
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 10, findtime: 1.minute, bantime: 1.hour) do
      req.path == '/users/sign_in' && req.post?
    end
  end

  self.throttled_responder = lambda do |_env|
    [429, { 'Content-Type' => 'text/plain' }, ["Muitas tentativas. Aguarde e tente novamente.\n"]]
  end

  self.blocklisted_responder = lambda do |_env|
    [403, { 'Content-Type' => 'text/plain' }, ["Acesso temporariamente bloqueado por excesso de tentativas.\n"]]
  end
end
