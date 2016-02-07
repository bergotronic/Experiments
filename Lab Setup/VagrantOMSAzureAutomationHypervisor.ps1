################################################
############    LAB BUILD SCRIPT    ############
################################################
<#

    .SYNOPSIS
    Downloads / Installs a number of things to build a new OMS / Azure Automation / Hypervisor with Vagrant for Machien deployment

    .DESCRIPTION

    The Get-Inventory function uses Windows Management Instrumentation (WMI) toretrieve service pack version, operating system build number, and BIOS serial number from one or more remote computers. 

    Computer names or IP addresses are expected as pipeline input, or may bepassed to the –computerName parameter. 

    Each computer is contacted sequentially, not in parallel.

    .NOTES
    Cool.

#>


$OMSINstaller_url = "microsoft"
$OMS_fileStore = 'C:\Share\MMASetup-AMD64.exe'

$VagrantInstaller_url = 'https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.msi'
$vagrant_fileStore = 'C:\Share\vagrant_1.8.1.msi'
$vagrant_Folder = "C:\HashiCorp"

$OPINSIGHTS_WORKSPACE_ID  = "abcd"
$OPINSIGHTS_WORKSPACE_KEY = "abcd"

$AzureAutomation_Name = ''
$AzureAutomation_Endpoint = ''
$AzureAutomation_Token =  ''


#install HyperV
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -Verbose

#INSTALL OMS
#MMASetup-AMD64.exe /C:"setup.exe /qn ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_ID=$OPINSIGHTS_WORKSPACE_ID OPINSIGHTS_WORKSPACE_KEY=$OPINSIGHTS_WORKSPACE_KEY AcceptEndUserLicenseAgreement=1"

#INSTALL HYBRID WORKER
#cd "C:\Program Files\Microsoft Monitoring Agent\Agent\AzureAutomation\<version>\HybridRegistration"
#Import-Module HybridRegistration.psd1
#Add-HybridRunbookWorker –Name $AzureAutomation_Name -EndPoint $AzureAutomation_Endpoint -Token $AzureAutomation_Token


#INSTALL Vagrant
IF(Test-Path $vagrant_fileStore)
{
    Write-Output "Vagrant Found!"  
}
ELSE
{
    Write-Output "Vagrant Download Starting!"
    $start_time = Get-Date
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($VagrantInstaller_url, $vagrant_fileStore)
    Write-Output "Vagrant Download Complete"
}


#RUN Vagrant

$ExperimentCounter = 33

$MachineName = "test" + $ExperimentCounter
$ExperimentDirectory = $vagrant_Folder + "\$MachineName" 

Set-Location $vagrant_Folder

IF(Test-Path $vagrant_fileStore)
{
    Write-Output "Vagrant Found!"  
}
ELSE
{
    New-Item $ExperimentDirectory -type directory
}

Set-Location  $ExperimentDirectory


#do the vagrant

#init the Vagrant
vagrant init hashicorp/precise64

#Up the vagrant
vagrant up --provider hyperv
