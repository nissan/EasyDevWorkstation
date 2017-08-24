#Script Name: New-EasyDevWorkstation-SPFx.ps1
#Purpose: Quick and clean way to setup a simple developer workstation for building SPFx (SharePoint Framework) webparts. Tested only for Windows 10
#Author Nissan Dookeran
#Date 23-08-2016
#Version 0.01

#set the execution policy to allow chocolatey to install and chocolatey scripts to install software
Set-ExecutionPolicy RemoteSigned

#install chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
refreshenv

#Install the basics - Git, Chrome browser, updated Powershell (if running on older Windows like Win Server 2008R2)
# Visual Studio Code (which is free), and latest SQL Server Management Studio (also free)
# Utilities like Microsoft Azure Storage Explorer, Postman and Fiddler are handy to have
# nodejs is essential for building SPFx webparts, as required components installed via npm (Node Package Manager)
choco install -y --allow-empty-checksums git GoogleChrome powershell visualstudiocode sql-server-management-studio postman fiddler4 microsoftazurestorageexplorer nodejs

refreshenv
#note if these do not work, close and reopen PowerShell window as PATH hasn't updated to recognize node and npm commands

#The basics: Gulp and Yeoman generator first, then the Microsoft SharePoint generator
npm install -g yo gulp
npm install -g @microsoft/generator-sharepoint

# Also need the windows build tools to install python 2.7 and vc++build tools as Visual Studio may not be present
# or may not have installed these components, and it's needed to build some of the spfx examples
npm install --global --production windows-build-tools

#Create a source code folder and clone the samples for SPFx available on github, this code is awesome
cd ~/Documents
mkdir Source
cd Source
git clone https://github.com/SharePoint/sp-dev-fx-webparts.git
