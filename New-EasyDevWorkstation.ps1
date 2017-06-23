#Script Name: New-EasyDevWorkstation.ps1
#Purpose: Quick and clean way to setup a simple developer workstation. Tested only for Windows 10
#Author Nissan Dookeran
#Date 23-06-2016
#Version 0.01

#set the execution policy to allow chocolatey to install and chocolatey scripts to install software
Set-ExecutionPolicy RemoteSigned

#install chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
refreshenv

#Install the basics - Git, Chrome browser, updated Powershell (if running on older Windows like Win Server 2008R2)
# Visual Studio Code (which is free), and latest SQL Server Management Studio (also free)
choco install -y --allow-empty-checksums git GoogleChrome powershell visualstudiocode sql-server-management-studio
