﻿<#

.SYNOPSIS

Quick and clean way to setup a simple developer workstation. Tested only for Windows 10. Modified to work with Readify environment



.NOTES

MUST RUN AS ADMINISTRATOR AS WINDOWS FEATURES ARE POSSIBLY INSTALLED

Script Name: New-ReddiDevWorkstation.ps1



Purpose: Quick and clean way to setup a simple developer workstation. Tested only for Windows 10. Highly opinionated to tools I would use in my environment.


Author Nissan Dookeran



Date 26-10-2017



Version 1.00



ChangeLog

1.00

Modified 

- Renamed main script to New-ReddiDevWorkstation (since it reflects my personal preferences so much, 
    which makes it "easy" for me, but can't be sure about anyone else whose opinions differ)
- Parameterized different workloads so you get a base installation of stuff without any switches, 
    but can use switches to install additional tools as needed

- Fix version of node and npm installed to match SPFx compatibility as per MS Docs documentation.



Add 

- Slack to default installation of tools 
    (because if you're not using some kind of tool to connect to a community, you're not giving back and also not learning efficiently)
- switch to install Office 365 Pro Plus (32 bit), Slack desktop app as installed
- install the Angular CLI
- install the Hyper-V feature if not enabled (useful for docker work)
- install Docker CE for Windows
- Install the Linux subsystem (Win 10 or Win 2016 Server only)
- firefox
- Install Nuget and set PSRepository to Trusted to allow install of Powershell modules more easily




Remove

- fiddler4 (no longer listed as a chocolatey package)
- powerbi (broken chocolatey installer)



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

    [parameter(Mandatory=$false)] [bool] $InstallDocker,
    [parameter(Mandatory=$false)] [bool] $InstallVisualStudio2017Full,
    [parameter(Mandatory=$false)] [bool] $InstallVisualStudioCode,
    [parameter(Mandatory=$false)] [bool] $InstallPowershellModules,
    [parameter(Mandatory=$false)] [bool] $ConfigureForSPFxDevelopment,
    [parameter(Mandatory=$false)] [bool] $ConfigureForPythonDevelopment,
    [parameter(Mandatory=$false)] [bool] $ConfigureForAngularDevelopment,
    [parameter(Mandatory=$false)] [bool] $ConfigureLinuxSubsystem,
    [parameter(Mandatory=$false)] [bool] $InstallOffice32bit

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

"@


iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

refreshenv

#Enable global confirmations so no prompting to stop deployment

choco feature enable -n allowGlobalConfirmation

choco install -y --allow-empty-checksums slack googlechrome powershell git postman nvm cmder jq jetbrainstoolbox firefox

if ($InstallDocker) {
#Install Hyper-V Windows Feature (if not yet installed) then install Docker
    Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All
    choco install -y --allow-empty-checksums docker-for-windows
}

if ($InstallVisualStudioCode) {
    choco install -y --allow-empty-checksums visualstudiocode

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

}

if ($InstallVisualStudio2017Full){

    #Install Visual Studio 2017 and the workloads for Azure and Web Development
    # To use another version of Visual Studio or add different workloads 
    #uncomment the line as appropriate until I get around to parametizing these versions and workloads as options

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

    #.Net Core Cross platform development
    choco install -y --allow-empty-checksums visualstudio2017-workload-netcoretools

    #ASP.Net and web development
    choco install -y --allow-empty-checksums visualstudio2017-workload-netweb

    #Office/SharePoint development
    choco install -y --allow-empty-checksums visualstudio2017-workload-office

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
    
    #Mobile development with .NET
    #choco install -y --allow-empty-checksums visualstudio2017-workload-netcrossplat

    #Node.js development
    #choco install -y --allow-empty-checksums visualstudio2017-workload-node

    #Universal Windows Platform Development
    #choco install -y --allow-empty-checksums visualstudio2017-workload-universal

    #Visual Studio extension development
    #choco install -y --allow-empty-checksums visualstudio2017-workload-visualstudioextension

    #Mobile development with Javascript
    #choco install -y --allow-empty-checksums visualstudio2017-workload-webcrossplat
    
    #Also install SQL Server Management studio, since if using VS2017 you're probably doing SQL Server DB stuff too
    choco install -y --allow-empty-checksums sql-server-management-studio
}


if ($InstallPowershellModules)
{
    #Install NuGet library and mark it as trusted
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

    #Install the Azure Resource Manager and SharePoint PNP Powershell modules
    Install-Module AzureRM -AllowClobber
    Install-Module SharePointPnPPowerShellOnline -AllowClob
    
}

if ($ConfigureForPythonDevelopment)
{
    choco install python3 anaconda3 pycharm
}
if ($ConfigureForAngularDevelopment)
{
    # Install for angular development
    nvm install 9.5.0
    nvm use 9.5.0
    RefreshEnv.cmd
    # Install Angular CLI
    npm install -g @angular/cli

}

if ($ConfigureForSPFxDevelopment)
{
   #install latest compatible nodejs and activate
    nvm install 6.11.5
    nvm use 6.11.5 #needed for spfx compatibility for now
    RefreshEnv.cmd
    #The basics: Gulp and Yeoman generator first, then the Microsoft SharePoint generator
    #RefreshEnv doesn't allow code to be found, next line will fix this.
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

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
    git clone https://github.com/SharePoint/sp-dev-fx-extensions.git

}

# Install Office 365 32 bit, no choco package for 64bit found
if ($InstallOffice32bit)
{

    choco install -y --allow-empty-checksums office365proplus 

}

#Need to follow up with steps from https://docs.microsoft.com/en-us/windows/wsl/install-win10
if ($ConfigureLinuxSubsystem)
{
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
} 
