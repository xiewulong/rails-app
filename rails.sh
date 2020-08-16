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
elif [ $1 = "apidoc" ]; then
  docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i && npm run apidoc && chown $UID:$GID -R ./node_modules ./public/apidoc"
  # docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i --registry=https://registry.npm.taobao.org && npm run apidoc && chown $UID:$GID -R ./node_modules ./public/apidoc"
elif [ $1 = "swagger" ]; then
  docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i && npm run swagger && chown $UID:$GID -R ./node_modules ./public/swagger"
  # docker run --rm -i -v $CSD:/app node:current-alpine sh -c "cd /app && npm i --registry=https://registry.npm.taobao.org && npm run swagger && chown $UID:$GID -R ./node_modules ./public/swagger"
else
  docker-compose exec app rails $@
  docker-compose exec app chown $UID:$GID -R .
fi

cd $CWD
