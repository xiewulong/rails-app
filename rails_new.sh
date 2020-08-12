#/bin/sh

gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
bundle config mirror.https://rubygems.org https://gems.ruby-china.com

cd `dirname $0`

rails new . \
      --api \
      --database=sqlite3 \
      --force \
      --skip-action-mailbox \
      --skip-action-mailer \
      --skip-action-cable \
      --skip-bundle \
      --skip-sprockets \
      --skip-spring \
      --skip-turbolinks

bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
