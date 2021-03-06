#! /bin/sh

### BEGIN INIT INFO
# Provides:          blog_poster
# Short-Description: starts blog poster script
# Description:       starts blog poster
### END INIT INFO

# Change these to match your app:
APP_NAME=blog_poster
RBENV_RUBY_VERSION=2.4.0
USER_DIR="/Users/$USER"
APP_PATH="$USER_DIR/dev/$APP_NAME"

# env
PATH="$PATH:$APP_PATH"
APP_SCRIPT="$APP_PATH/$APP_NAME.rb"

# 
CMD="$APP_SCRIPT"

# get the login info for the user
echo 'setting up environment'
source "$USER_DIR/.profile"

cd $APP_PATH || exit 1
echo 'checking git'
"$CMD"