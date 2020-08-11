#/bin/sh

# Current work directory
CWD=`pwd`

# Current script directory
CSD=$(cd `dirname $0`; pwd)

cd $CSD

if [ -f "rails_new.sh" ]; then
  docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c /app/rails_new.sh
  rm -rf rails_new.sh
fi

docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c "cd /app && rails $@ && adduser -DH $USER && chown $USER:$USER -R ."

cd $CWD
