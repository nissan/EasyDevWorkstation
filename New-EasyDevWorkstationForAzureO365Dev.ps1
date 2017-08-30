#Script Name: New-EasyDevWorkstation.ps1
#Purpose: Quick and clean way to setup a simple developer workstation. Tested only for Windows 10
#Author Nissan Dookeran
#Date 30-08-2017
#Version 0.03

#ChangeLog
# 0.03 
# Remove
# officedevtools
#
# Add
# Visual Studio full suite reference
# SPFx required components
# Merge the SPFx script into this one.

#set the execution policy to allow chocolatey to install and chocolatey scripts to install software
#Use ByPass to avoid prompts when installing PowerShell modules
Set-ExecutionPolicy Bypass

#install chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
refreshenv

#Install the basics - Git, Chrome browser, updated Powershell (if running on older Windows like Win Server 2008R2)
# Visual Studio Code (which is free), and latest SQL Server Management Studio (also free)
# Utilities like Microsoft Azure Storage Explorer, Postman and Fiddler are handy to have
# PowerBI Desktop
# nodejs is essential for building SPFx webparts, as required components installed via npm (Node Package Manager)

choco install -y --allow-empty-checksums git GoogleChrome powershell visualstudiocode sql-server-management-studio postman fiddler4 powerbi microsoftazurestorageexplorer nodejs


#Install Visual Studio 2017 and the workloads for Azure and Web Development

# To use another version of Visual Studio uncomment the line as appropriate

#Community edition
#choco install -y --allow-empty-checksums visualstudio2017community

#Professional edition
#choco install -y --allow-empty-checksums visualstudio2017professional

#Install enterprise edition of Visual Studio 2017
choco install -y --allow-empty-checksums visualstudio2017enterprise

#Comment and uncomment workloads to install for Visual Studio as appropriate
#More information on workloads can be found at https://www.visualstudio.com/vs/visual-studio-workloads/

#Azure development
choco install -y --allow-empty-checksums visualstudio2017-workload-azure

# Data storage and processing
choco install -y --allow-empty-checksums visualstudio2017-workload-data

#.Net Desktop development
choco install -y --allow-empty-checksums visualstudio2017-workload-manageddesktop

#Game development with Unity workload
choco install -y --allow-empty-checksums visualstudio2017-workload-managedgame

#Linux development with C++
choco install -y --allow-empty-checksums visualstudio2017-workload-nativecrossplat

#Desktop development with C++
choco upgrade -y --allow-empty-checksums visualstudio2017-workload-nativedesktop

#Game development with C++
choco install -y --allow-empty-checksums visualstudio2017-workload-nativegame

#Mobile development with C++
choco install -y --allow-empty-checksums visualstudio2017-workload-nativemobile

#.Net Core Cross platform development
choco install -y --allow-empty-checksums visualstudio2017-workload-netcoretools

#Mobile development with .NET
choco install -y --allow-empty-checksums visualstudio2017-workload-netcrossplat

#ASP.Net and web development
choco install -y --allow-empty-checksums visualstudio2017-workload-netweb

#Node.js development
choco install -y --allow-empty-checksums visualstudio2017-workload-node

#Office/SharePoint development
choco install -y --allow-empty-checksums visualstudio2017-workload-office

#Universal Windows Platform Development
choco install -y --allow-empty-checksums visualstudio2017-workload-universal

#Visual Studio extension development
choco install -y --allow-empty-checksums visualstudio2017-workload-visualstudioextension

#Mobile development with Javascript
choco install -y --allow-empty-checksums visualstudio2017-workload-webcrossplat

#Install the Azure Resource Manager and SharePoint PNP Powershell modules
Install-Module AzureRM -AllowClobber
Install-Module SharePointPnPPowerShellOnline -AllowClobber

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
mkdir Repos
cd Repos
git clone https://github.com/SharePoint/sp-dev-fx-webparts.git
