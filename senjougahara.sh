##
## Senjougahara is a 2014 macbook pro
##

echo "Senjougahara configuration ..."

## Global mac configuration
source $HOME/.my/_osx.sh

# Android stuff
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

# added by travis gem
[ -f /Users/morgotth/.travis/travis.sh ] && source /Users/morgotth/.travis/travis.sh
