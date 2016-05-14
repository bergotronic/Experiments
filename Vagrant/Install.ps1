#Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))


Get-PackageProvider -Name NuGet -ForceBootstrap

#Install GIT
choco install git.install

#INSTALL BoxStarter
choco install boxstarter