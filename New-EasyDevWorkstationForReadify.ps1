<#
.SYNOPSIS
Quick and clean way to setup a simple developer workstation. Tested only for Windows 10. Modified to work with Readify environment

.NOTES
MUST RUN AS ADMINISTRATOR AS WINDOWS FEATURES ARE POSSIBLY INSTALLED
Script Name: New-EasyDevWorkstation.ps1

Purpose: Quick and clean way to setup a simple developer workstation. Tested only for Windows 10. Modified to work with Readify environment

Author Nissan Dookeran

Date 26-10-2017

Version 1.00

ChangeLog
1.00
Modified 
- Customized for Readify specific work
- Fix version of node and npm installed to match SPFx compatibility as per MS Docs documentation.

Add 
- switch to install Office 365 Pro Plus (32 bit), Microsoft Teams 32-bit desktop app, Slack desktop app as installed
- install the Angular CLI
- install the Hyper-V feature if not enabled (useful for docker work)
- install Docker CE for Windows
- firefox

Remove
- git cloning of SPFx samples repositories

TODO # Add Office 365 64bit, Teams 64 bit and Yammer 64-bit software as part of installation, no chocolatey package exists for these yet

0.03.5
Add docker toolbox for management of containers
Replace nodejs with nvm, so that multiple versions of nodejs can be installed.
Add commands for nvm to install and use latest version available of nodejs
0.03.4
Fix
Adjust execution policy to "RemoteSigned" from "Bypass"
Add
jetbrainstoolbox to allow addition of various community IDEs like IntelliJ
Remove


0.03.3
Fix
Issue #6 - Code extensions do not install: Fixed
0.03.2
Add
Visual Studio code extensions for C#, Chrome debugging, Powershell
and a Markdown theming kit for VSCode
0.03.1
Add
jq
cmder
resharper
Enable chocolatey feature to allows say yes to prompts so won't pause during execution

0.03 
Remove
officedevtools

Add
Visual Studio full suite reference
SPFx required components
Merge the SPFx script into this one.

#>
param(
    [parameter(Mandatory=$false)] [bool] $Use32BitSoftware
)
Write-Host @"
___________                                                                          
\_   _____/____    _________.__.                                                     
 |    __)_\__  \  /  ___<   |  |                                                     
 |        \/ __ \_\___ \ \___  |                                                     
/_______  (____  /____  >/ ____|                                                     
        \/     \/     \/ \/                                                          
________                     .__                                                     
\______ \   _______  __ ____ |  |   ____ ______   ___________                        
 |    |  \_/ __ \  \/ // __ \|  |  /  _ \\____ \_/ __ \_  __ \                       
 |    `   \  ___/\   /\  ___/|  |_(  <_> )  |_> >  ___/|  | \/                       
/_______  /\___  >\_/  \___  >____/\____/|   __/ \___  >__|                          
        \/     \/          \/            |__|        \/                              
 __      __             __              __          __  .__                          
/  \    /  \___________|  | __  _______/  |______ _/  |_|__| ____   ____             
\   \/\/   /  _ \_  __ \  |/ / /  ___/\   __\__  \\   __\  |/  _ \ /    \            
 \        (  <_> )  | \/    <  \___ \  |  |  / __ \|  | |  (  <_> )   |  \           
  \__/\  / \____/|__|  |__|_ \/____  > |__| (____  /__| |__|\____/|___|  /           
       \/                   \/     \/            \/                    \/            
  _________       __                 ___________           .__     ____    _______   
 /   _____/ _____/  |_ __ ________   \__    ___/___   ____ |  |   /_   |   \   _  \  
 \_____  \_/ __ \   __\  |  \____ \    |    | /  _ \ /  _ \|  |    |   |   /  /_\  \ 
 /        \  ___/|  | |  |  /  |_> >   |    |(  <_> |  <_> )  |__  |   |   \  \_/   \
/_______  /\___  >__| |____/|   __/    |____| \____/ \____/|____/  |___| /\ \_____  /
        \/     \/           |__|                                         \/       \/ 
___________            __________                   .___.__  _____                   
\_   _____/__________  \______   \ ____ _____     __| _/|__|/ ____\__.__.            
 |    __)/  _ \_  __ \  |       _// __ \\__  \   / __ | |  \   __<   |  |            
 |     \(  <_> )  | \/  |    |   \  ___/ / __ \_/ /_/ | |  ||  |  \___  |            
 \___  / \____/|__|     |____|_  /\___  >____  /\____ | |__||__|  / ____|            
     \/                        \/     \/     \/      \/           \/                 
"@

#set the execution policy to allow chocolatey to install and chocolatey scripts to install software
#Use RemoteSigned to avoid prompts when installing PowerShell modules
Set-ExecutionPolicy RemoteSigned
#install chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
refreshenv
#Enable global confirmations so no prompting to stop deployment
choco feature enable -n allowGlobalConfirmation

# Install the work management and communications tools first, Microsoft Teams, Slack, Office 365
if ($Use32BitSoftware)
{
    choco install -y --allow-empty-checksums office365proplus microsoft-teams 
}
choco install -y --allow-empty-checksums slack
#Install the basics - Git, Chrome browser, updated Powershell (if running on older Windows like Win Server 2008R2)
# Visual Studio Code (which is free), and latest SQL Server Management Studio (also free)
# Utilities like Microsoft Azure Storage Explorer, Postman and Fiddler are handy to have
# PowerBI Desktop
# nodejs is essential for building SPFx webparts, as required components installed via npm (Node Package Manager),
# install nodist to allow installation of multiple versions of nodejs
#jq is a powerful command line tool for parsing JSON files
choco install -y --allow-empty-checksums git GoogleChrome powershell sql-server-management-studio postman fiddler4 powerbi microsoftazurestorageexplorer nvm cmder jq
# Install Jetbrains Toolbox, Visual Studio Code and install common extensions needed
# Install docker-toolbox to setup containers as needed
choco install -y --allow-empty-checksums visualstudiocode jetbrainstoolbox docker-toolbox
RefreshEnv.cmd
#RefreshEnv doesn't allow code to be found, next line will fix this.
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
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
#choco install -y --allow-empty-checksums visualstudio2017-workload-managedgame

#Linux development with C++
#choco install -y --allow-empty-checksums visualstudio2017-workload-nativecrossplat

#Desktop development with C++
#choco upgrade -y --allow-empty-checksums visualstudio2017-workload-nativedesktop

#Game development with C++
#choco install -y --allow-empty-checksums visualstudio2017-workload-nativegame

#Mobile development with C++
#choco install -y --allow-empty-checksums visualstudio2017-workload-nativemobile

#.Net Core Cross platform development
choco install -y --allow-empty-checksums visualstudio2017-workload-netcoretools

#Mobile development with .NET
choco install -y --allow-empty-checksums visualstudio2017-workload-netcrossplat

#ASP.Net and web development
choco install -y --allow-empty-checksums visualstudio2017-workload-netweb

#Node.js development
#choco install -y --allow-empty-checksums visualstudio2017-workload-node

#Office/SharePoint development
choco install -y --allow-empty-checksums visualstudio2017-workload-office

#Universal Windows Platform Development
#choco install -y --allow-empty-checksums visualstudio2017-workload-universal

#Visual Studio extension development
#choco install -y --allow-empty-checksums visualstudio2017-workload-visualstudioextension

#Mobile development with Javascript
#choco install -y --allow-empty-checksums visualstudio2017-workload-webcrossplat

#If you have the license for it, Resharper's a good VS add-in to have
choco install -y --allow-empty-checksum resharper

#Install the Azure Resource Manager and SharePoint PNP Powershell modules
Install-Module AzureRM -AllowClobber
Install-Module SharePointPnPPowerShellOnline -AllowClobber

refreshenv
#note if these do not work, close and reopen PowerShell window as PATH hasn't updated to recognize node and npm commands
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
#This should work if refreshenv does not

#install latest nodejs and activate
nvm install latest
nvm install 6.11.5
nvm use 6.11.5 #needed for spfx compatibility for now
#The basics: Gulp and Yeoman generator first, then the Microsoft SharePoint generator
#RefreshEnv doesn't allow code to be found, next line will fix this.
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

npm install -g yo gulp
npm install -g @microsoft/generator-sharepoint

# Install Angular CLI
npm install -g @angular/cli


# Also need the windows build tools to install python 2.7 and vc++build tools as Visual Studio may not be present
# or may not have installed these components, and it's needed to build some of the spfx examples
npm install --global --production windows-build-tools

#Create a source code folder and clone the samples for SPFx available on github, this code is awesome
# cd ~/Documents
# mkdir Source
# cd Source
# mkdir Repos
# cd Repos
# git clone https://github.com/SharePoint/sp-dev-fx-webparts.git
# git clone https://github.com/SharePoint/sp-dev-fx-extensions.git


#Install Hyper-V Windows Feature (if not yet installed) then install Docker
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All
choco install -y --allow-empty-checksums docker-for-windows
