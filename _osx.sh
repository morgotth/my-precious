##
## Common OSX configuration part
##

## VARS

export PIP_DOWNLOAD_CACHE='/var/tmp/pip-cache';
# Setup brew cask to install into /Applications folder.
export HOMEBREW_CASK_OPTS='--appdir=/Applications';
# Promote gnu utils from homebrew
if [ $(brew list | grep coreutils | wc -l) != 0 ];then
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

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

