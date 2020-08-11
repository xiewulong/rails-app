#/bin/sh

USERNAME=username

# Current work directory
CWD=`pwd`

# Current script directory
CSD=$(cd `dirname $0`; pwd)

set -ex

cd $CSD

if [ -d "rails_new.sh" ]; then
  docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c /app/rails_new.sh
  rm -rf rails_new.sh
fi

docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c "cd /app && adduser -DH $USERNAME && chown $USERNAME:$USERNAME -R ."

cd $CWD
