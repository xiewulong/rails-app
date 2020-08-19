FROM xiewulong/rails:alpine

RUN set -ex && \
    # sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps && \
    apk add --no-cache \
      # mysql-dev \
      # nodejs \
      # postgresql-dev \
      sqlite-dev \
      tzdata \
      # yarn \
    && \
    # gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    # bundle config mirror.https://rubygems.org https://gems.ruby-china.com && \
    apk del .build-deps

CMD { rails db:migrate || rails db:setup } ; rails s -b 0.0.0.0 -p 3000

EXPOSE 3000

WORKDIR /app

ADD . .

RUN bundle
