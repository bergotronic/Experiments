#OPEN UP WINRM
winrm set winrm/config/client @{TrustedHosts="*"}
net start w32time
w32tm /resync

Enable-PSRemoting –force

#Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

#Install GIT
choco install git.install -yes

#Install Post V5
choco install powershell -yes --force

#Set DNS to Domain Server
netsh int ip set dns "Ethernet" static 192.168.200.130

#Add To Domain
#$DomainAdmin = "BERG\BERGDA"
#$password = "P@ssword"  
#$password = ConvertTo-SecureString -String $password -asplaintext -force
#$credential = New-Object System.Management.Automation.PSCredential $DomainAdmin,$password

#Add-Computer -domainname "BERG" -cred $credential -force

