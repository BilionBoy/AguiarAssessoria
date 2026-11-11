# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AguiarAssessoria
  class Application < Rails::Application # rubocop:disable Style/Documentation
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.paths['lib/templates/erb/scaffold'] = 'lib/templates/erb/scaffold'

    config.time_zone = 'La Paz' # Configuração do Time Zone

    config.i18n.default_locale = :'pt-BR' # Configuração do idioma padrão

    # Em produção o acesso chega assim: usuário → Cloudflare → Nginx do host → Puma.
    # Sem marcar o Cloudflare como proxy confiável, request.remote_ip devolve o IP
    # do servidor do Cloudflare em vez do IP do usuário, e o Rack::Attack passa a
    # contar e bloquear por servidor do Cloudflare (bloqueando gente inocente que
    # passa por ele). O cabeçalho só é aceito quando vem de um IP desta lista, então
    # quem acessar o servidor direto não consegue forjar o próprio IP.
    # Lista oficial: https://www.cloudflare.com/ips/
    cloudflare_ips = %w[
      173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18
      108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17
      162.158.0.0/15 104.16.0.0/13 104.24.0.0/14 172.64.0.0/13 131.0.72.0/22
      2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32
      2a06:98c0::/29 2c0f:f248::/32
    ].map { |range| IPAddr.new(range) }
    config.action_dispatch.trusted_proxies = ActionDispatch::RemoteIp::TRUSTED_PROXIES + cloudflare_ips
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
