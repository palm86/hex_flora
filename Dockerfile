FROM elixir:1.12-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base git npm

# add glibc in order to use dart-sass on alpine linux
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk
RUN apk add glibc-2.34-r0.apk

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

COPY config/config.exs config/prod.exs config/
RUN mix deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN mix assets.deploy

# compile and build release
COPY lib lib
RUN mix compile

# uncomment COPY if rel/ exists
COPY rel rel
COPY config/runtime.exs config/
RUN mix release

# prepare release image
FROM alpine:3.16 AS app
RUN apk add --no-cache openssl ncurses-libs build-base

# Appended by flyctl
ENV ECTO_IPV6 true
ENV ERL_AFLAGS "-proto_dist inet6_tcp"

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/hex_flora ./

ENV HOME=/app

CMD ["bin/hex_flora", "start"]
