#/bin/sh

# Current work directory
CWD=`pwd`

# Current script directory
CSD=$(cd `dirname $0`; pwd)

GID=`id | awk '{print $2}' | awk -F "(" '{print $1}' | awk -F "=" '{print $2}'`

cd $CSD

if [ -f "rails_new.sh" ]; then
  docker run --rm -i -v $CSD:/app xiewulong/rails:alpine sh -c /app/rails_new.sh
  rm -rf rails_new.sh
  docker run --rm -i -v $CSD:/app xiewulong/rails:alpine sh -c "cd /app && chown $UID:$GID -R ."
  echo '' >> ./.gitignore
  echo '# Custom' >> ./.gitignore
  echo '/node_modules' >> ./.gitignore
  echo 'docker-compose.yml' >> ./.gitignore
elif [ "$1" = "doc" ]; then
  docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i && npm run doc && chown $UID:$GID -R ./node_modules ./public/doc"
  # docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i --registry=https://registry.npm.taobao.org && npm run doc && chown $UID:$GID -R ./node_modules ./public/doc"
  sed -i 's/articles.push({/var url_prefix=location.href.replace(\/\\\/doc\\\/.*$\/,"");fields.article.examples\&\&fields.article.examples.forEach(function(e){e.content=e.content.replace(\/http:\\\/\\\/localhost\/g,url_prefix)});fields.article.sampleRequest\&\&fields.article.sampleRequest.forEach(function(s){s.url=s.url.replace(\/^\\s+\/,url_prefix)});articles.push({/' ./public/doc/main.js
else
  docker-compose exec app rails $@
  docker-compose exec app chown $UID:$GID -R .
fi

cd $CWD
