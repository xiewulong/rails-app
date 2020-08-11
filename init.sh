#/bin/sh

set -ex

if [ -d "init.sh" ]; then
  gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
  bundle config mirror.https://rubygems.org https://gems.ruby-china.com

  cd /app

  rails new --api -B .
  bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java

  adduser -DH xiewulong
  chown xiewulong:xiewulong -R .

  rm -rf init.sh
fi
