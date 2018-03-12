
#!/bin/bash

echo "Script Name: New-ReddiDevWorkstation.sh"
echo "Purpose: Quick and clean way to setup a simple developer workstation."
echo "Tested only for Mac OSX High Sierra."
echo "Highly opinionated to tools I use in my environment."
echo "-----------------------------------"
echo "Author: Nissan Dookeran <nissan.dookeran@gmail.com>"
echo "Date Last Modified: 12-03-2018"
echo "Version 0.02"
echo "-----------------------------------"
echo " ChangeLog"
echo " Add: " 
echo " Meld as merge tool for git"
echo "--------------------------------------"
echo " Easy Developer Workstation Setup Tool For Mac 0.02"
echo "--------------------------------------"

#install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Install mac-specific build tools
xcode-select --install

#install prerequisites
brew install automake autoconf apple-gcc42 openssl

#install java
brew cask install java
brew install caskroom/cask/intellij-idea

#Install browsers
brew install caskroom/cask/google-chrome
brew install caskroom/cask/firefox

#Install source control
brew install git
git config --global color.ui auto
#Install meld as git merge tool
brew install caskroom/cask/meld
git config --global merge.tool "meld"
git config --global mergetool.meld.path "/usr/local/bin/meld"

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
mkdir ~/.nvm
echo "export NVM_DIR=~/.nvm" >>~/.bash_profile
echo "source $(brew --prefix nvm)/nvm.sh">> ~/.bash_profile
source ~/.bash_profile

#Install SPFx
nvm install 6.11.5
nvm use 6.11.5 #needed for spfx compatibility for now
npm install -g yo gulp
npm install -g @microsoft/generator-sharepoint

# Install Angular CLI
nvm install 9.5.0
nvm use 9.5.0
npm install -g @angular/cli

brew install caskroom/cask/webstorm

#Install go packages
brew install go
brew install caskroom/cask/goland

#Install python packages
brew install python3
brew install caskroom/cask/anaconda
brew install caskroom/cask/pycharm

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
brew install caskroom/cask/rubymine

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

brew install caskroom/cask/parallels


