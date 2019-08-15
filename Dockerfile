FROM bitwalker/alpine-elixir-phoenix:latest

EXPOSE 4000

ARG APP_NAME=derivco_app
ARG APP_VSN=0.1.0
ARG MIX_ENV=prod
ARG SECRET_KEY_BASE=u1QXlca4XEZKb1o3HL/aUlznI1qstCNAQ6yme/lFbFIs0Iqiq/annZ+Ty8JyUCDc
ARG PORT=4000
ARG HOSTNAME=localhost

ENV APP_NAME=${APP_NAME} \
  APP_VSN=${APP_VSN} \
  MIX_ENV=${MIX_ENV} \
  HOSTNAME=${HOSTNAME} \
  PORT=${PORT} \ 
  SECRET_KEY_BASE=${SECRET_KEY_BASE}

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

# Run frontend build, compile, and digest assets
RUN mix do compile, phx.digest

USER default

CMD ["mix", "phx.server"]