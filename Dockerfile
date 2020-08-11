FROM ruby:alpine

RUN set -ex && \
    sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps \
      build-base \
      # mysql-client \
      nodejs \
      # postgresql-client \
      sqlite \
      yarn \
    && \
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    bundle config mirror.https://rubygems.org https://gems.ruby-china.com && \
    gem install rails && \
    apk del .build-deps

EXPOSE 3000

CMD [ "rails", "s", "-b", "0.0.0.0" ]

WORKDIR /app

ADD . .
