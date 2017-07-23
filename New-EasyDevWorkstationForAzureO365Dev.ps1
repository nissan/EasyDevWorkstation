#Script Name: New-EasyDevWorkstation.ps1
#Purpose: Quick and clean way to setup a simple developer workstation. Tested only for Windows 10
#Author Nissan Dookeran
#Date 23-06-2016
#Version 0.01

#set the execution policy to allow chocolatey to install and chocolatey scripts to install software
#Use ByPass to avoid prompts when installing PowerShell modules
Set-ExecutionPolicy Bypass

#install chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
refreshenv

#Install the basics - Git, Chrome browser, updated Powershell (if running on older Windows like Win Server 2008R2)
# Visual Studio Code (which is free), and latest SQL Server Management Studio (also free)
# Fiddler4 and PostMan
# PowerBI Desktop
# SharePoint Online Management Shell (officedevtools)
choco install -y --allow-empty-checksums git GoogleChrome powershell visualstudiocode sql-server-management-studio postman fiddler4 powerbi officedevtools

#Install the Azure Resource Manager and SharePoint PNP Powershell modules
Install-Module AzureRM -AllowClobber
Install-Module SharePointPnPPowerShellOnline -AllowClobber


Set-ExecutionPolicy RemoteSigned