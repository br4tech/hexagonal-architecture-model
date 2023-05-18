FROM ruby:2.7.0-alpine

ARG USER_ID=1000
ARG GROUP_ID=1000

ENV APP_ROOT /app
ENV BUNDLE_PATH /usr/local/bundle
ENV USER=pronto
ENV GROUP=pronto

RUN addgroup -g $GROUP_ID --system $GROUP && \
    adduser -u $USER_ID --gecos '' -G $GROUP --disabled-password $USER

RUN apk add --update --no-cache --update --virtual run-dependencies \
      bash \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \   
      tzdata \
      yarn

ENV APP_ROOT /app
ENV BUNDLE_PATH /usr/local/bundle 

WORKDIR $APP_ROOT
ADD . $APP_ROOT

RUN chown -R $USER:$USER $APP_ROOT $BUNDLE_PATH
RUN chown -R $USER:$USER $BUNDLE_PATH
RUN gem update --system && gem install bundler -v 2.4.1

USER $USER

COPY --chown=$USER Gemfile* ./

RUN bundle install

COPY --chown=$USER_ID:$GROUP_ID . ./

RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
