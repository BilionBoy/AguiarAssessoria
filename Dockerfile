# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.5

# ---- estagio de build: compila gems e assets, nada disso vai pra imagem final ----
FROM ruby:${RUBY_VERSION}-slim AS build

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      libpq-dev \
      libvips42 \
      xfonts-75dpi xfonts-base \
      wkhtmltopdf xvfb \
      curl ca-certificates && \
    ln -sf /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

COPY . .

# Precisa de uma SECRET_KEY_BASE valida so pra rodar o precompile no build;
# a de verdade vem via RAILS_MASTER_KEY/env no container em runtime.
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

RUN rm -rf tmp/cache spec test log/*.log

# ---- estagio final: so o necessario pra RODAR a aplicacao ----
FROM ruby:${RUBY_VERSION}-slim

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      libpq5 \
      libvips42 \
      xfonts-75dpi xfonts-base \
      wkhtmltopdf xvfb \
      curl && \
    ln -sf /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid rails --create-home rails

WORKDIR /app

COPY --from=build --chown=rails:rails /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=rails:rails /app /app

RUN mkdir -p storage log tmp/pids tmp/cache && chown -R rails:rails storage log tmp

USER rails

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -f http://localhost:3000/up || exit 1

CMD ["sh", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0 -p 3000"]
