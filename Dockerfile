ARG APP_NAME=saxo_api
ARG APP_VERSION=0.2.0
ARG APP_HOME=/app
ARG APP_ENV=prod

#
# builder
#
FROM elixir:1.17.2-otp-27-alpine AS builder

ARG APP_NAME
ARG APP_VERSION
ARG APP_HOME
ARG APP_ENV

ENV APP_HOME=$APP_HOME \
    APP_NAME=$APP_NAME \
    APP_VERSION=$APP_VERSION
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV MIX_ENV=$APP_ENV
RUN mix local.hex --force

COPY mix.exs mix.lock $APP_HOME
RUN mix deps.get --only $MIX_ENV

COPY lib/ $APP_HOME/lib
COPY config/ $APP_HOME/config
RUN mix compile

#
# releaser
#
FROM builder AS releaser

COPY rel/ $APP_HOME/rel
RUN mix release

#
# runner
#
# FROM releaser AS runner
FROM elixir:1.17.2-otp-27-alpine AS runner
# FROM alpine:3.19 AS runner

ARG APP_NAME
ARG APP_VERSION
ARG APP_HOME

ENV REL_HOME=/opt/$APP_NAME
RUN mkdir -p $REL_HOME
WORKDIR $REL_HOME

COPY --from=releaser $APP_HOME/_build/prod/$APP_NAME-$APP_VERSION.tar.gz .
RUN tar -xzf $APP_NAME-$APP_VERSION.tar.gz

ENTRYPOINT ["bin/saxo_api"]
CMD ["start"]
