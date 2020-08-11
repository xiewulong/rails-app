#/bin/sh

# Current work directory
CWD=`pwd`

# Current script directory
CSD=$(cd `dirname $0`; pwd)

GID=`id | awk '{print $2}' | awk -F "(" '{print $1}' | awk -F "=" '{print $2}'`

cd $CSD

if [ -f "rails_new.sh" ]; then
  docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c /app/rails_new.sh
  rm -rf rails_new.sh
  docker run --rm -v $CSD:/app xiewulong/rails:alpine sh -c "cd /app && chown $UID:$GID -R ."
else
  docker exec app sh -c "rails $@ && chown $USER:$GID -R ."
fi

cd $CWD
