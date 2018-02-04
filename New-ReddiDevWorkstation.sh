#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Install mac-specific build tools
xcode-select --install

#install prerequisites
brew install automake autoconf apple-gcc42 openssl

#install java
brew cask install java

#Install browsers
brew install caskroom/cask/google-chrome
brew install caskroom/cask/firefox

#Install source control
brew install git

#Install jetbrains toolbox for managing what IDEs installed
brew install caskroom/cask/jetbrains-toolbox

#Install communication tools
brew install caskroom/cask/slack

#Install scripting 
brew install caskroom/cask/powershell

brew install caskroom/cask/postman
brew install jq

#Install for node or javascript frameworks development
brew install nvm
source ~/.bash_profile

# Install for angular development
nvm install 9.5.0
nvm use 9.5.0
# Install Angular CLI
npm install -g @angular/cli

#Install SPFx
npm install -g yo gulp
npm install -g @microsoft/generator-sharepoint

#Install go packages
brew install go


#Install python packages
brew install python3
brew install caskroom/cask/anaconda

#Install ruby packages
#################
# Install mpapis public key (might need `gpg2` and or `sudo`)
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# Download the installer
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
# Verify the installer signature (might need `gpg2`), and if it validates...
gpg --verify rvm-installer.asc &&
# Run the installer
bash rvm-installer stable
###################

#Install IDEs
brew install caskroom/cask/visual-studio-code
# Referenced https://code.visualstudio.com/docs/editor/extension-gallery 
# installing extensions via command line
# C#
code --install-extension ms-vscode.csharp
# Powershell
code --install-extension ms-vscode.PowerShell
# Debugger for chrome
code --install-extension msjsdiag.debugger-for-chrome
# Markdown theme kit (a theme I prefer)
code --install-extension ms-vscode.Theme-MarkdownKit

brew install caskroom/cask/visual-studio



