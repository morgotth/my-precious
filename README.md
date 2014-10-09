
# My precious #

The purpose of this project is to build **my precious** shell from scratch.

Installation:

```bash
# oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
curl -L http://install.ohmyz.sh | sh

# OSX commands
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install coreutils findutils autojump cmake ffmpeg gcc git go irssi latex2rtf mkvtoolnix ncdu scala tmux tree wget htop rename
brew install caskroom/cask/brew-cask

brew cask doctor
brew cask install vlc android-file-transfer dropbox mplayerx vlc skype alfred iterm2 spotify
brew cask install electrum libreoffice gimp virtualbox cyberduck google-chrome the-unarchiver tunnelblick
brew cask install qlmarkdown flash
# android-studio-bundle: android-studio + sdk
brew cask install android-studio-bundle genymotion
# alternative versions
brew tap caskroom/versions
brew cask install firefox-beta sublime-text3 keepassx0

# my-precious install
git clone https://github.com/morgotth/my-precious/ ~/.my
~/.my/init
```

# Dependencies #

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [autojump](https://github.com/joelthelion/autojump)

