##
## Common OSX configuration part
##

# Installation commands :
# brew install android-sdk cmake ffmpeg gcc git go irssi latex2rtf mkvtoolnix ncdu scala tmux tree wget
# brew install caskroom/cask/brew-cask
# brew cask install libreoffice vlc android-file-transfer atom dropbox electrum genymotion gimp mplayerx vlc

## VARS

export PIP_DOWNLOAD_CACHE='/var/tmp/pip-cache';
# Setup brew cask to install into /Applications folder.
export HOMEBREW_CASK_OPTS='--appdir=/Applications';

# fix encoding annoyances with less. See configuration with "locale" command.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

##
## functions
##

function bup {
    # Burp !!
    brew update && brew upgrade
}

