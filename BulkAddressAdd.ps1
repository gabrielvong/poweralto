<#
BulkAddressAdd.ps1
Created by: Gabriel Vong
Last modified: 30/05/2022
The script imports a formatted csv to loop through and create address objects to your candidate config
and put them to an new/existing address group you define. 

Please follow readme.md (https://github.com/gabrielvong/poweralto) to connect your PowerShell environment to Panorama.
Download inputexcel.csv and fill, create an empty scripterrorlog.txt text file, update "Environment Variables" session of this script before running.

While XML API will do most of the input validation, the script will also validate the following:
- If there is an existing address object with same name, log/show on console and ignore the entry
- log/show on console if an entry fails any XML API validation.

#>

function Register-Module {
[CmdletBinding()]
PARAM(
    [parameter(Mandatory=$true, Position=1)]
    [string]$Name,
    [parameter(Mandatory=$false, Position=2)]
    [string]$Version,
    [parameter(Mandatory=$false, Position=3)]
    [string]$Repository,
    [Switch]$AllowClobber
)

    $versionParam = @{ }

    if ($Version) {
        $versionParam.Add('RequiredVersion', $Version);
    }

    if ($Repository) {
        $versionParam.Add('Repository', $Repository);
    }
        
    if (-not (Get-Module -Name $Name -ListAvailable | where { [String]::IsNullOrEmpty($Version) -or $_.Version -eq $Version } )) {
        Write-Host "Install module $Name $Version"
        Install-Module -Name $Name -Force -Verbose -Scope AllUsers @versionParam -AllowClobber:$AllowClobber -ErrorAction Stop
    } else {
        Write-Host "Import module $Name $Version"
        Import-Module $Name @versionParam -ErrorAction Stop
    }
}

function Write-ErrorMessage {
[CmdletBinding()]
PARAM(
    [parameter(Mandatory=$false)]
    $Prefix = "Error",
    [parameter(Mandatory=$true, Position=1)]
    $Error
)

    $err = $_.Exception
    $indent = "" 
    $msg = ""

    while ($err) {
        if ($msg.Length -gt 0) {
            $msg += "`r`n${indent} => " 
        } else {
            $msg = "${Prefix} : "
        }

        $msg += $err.Message
        $indent += "  "
        $err = $err.InnerException
    }

 
    $host.UI.WriteErrorLine($msg)
}

Register-module -Name poweralto

#Envrionment Variables
$csvpath = "C:\Temp\"
$csvfile = "inputexcel.csv"
$errorlogpath = "C:\Temp\"
$errorlogfile = "scripterrorlog.txt"

#Full path of input files/Error logs
$csvfullpath = join-path -path $csvpath -ChildPath $csvfile
$errorlog = join-path -path $errorlogpath -ChildPath $errorlogfile


date >> $errorlog
$csvfullpath >> $errorlog

echo $csvfullpath
echo $errorlog


#Import CSV
$csv = Get-Content $csvfullpath  | ConvertFrom-CSV

#Looping csv to add address/addressgroup
foreach ($endpoint in $csv) {
    $AddressNames = ($endpoint.AddressName) 
    Foreach ($AddressName in $AddressNames) {
        try
        {
          $currentAddressName = get-PaAddress -Name $AddressName
          if (([string]::IsNullOrEmpty($currentAddressName))) {
           Set-PaAddress -Name $AddressName -Value $endpoint.AddressValue -Type $endpoint.Addresstype -Description $endpoint.AddressDescription -ErrorAction Stop
                if (-not ([string]::IsNullOrEmpty($endpoint.AddressGroup))) {
                   #Adding the new object to an address group, note this command will not wipe out other existing members of the address group
                   Set-PaAddressGroup -Name $endpoint.AddressGroup -Member $AddressName -ErrorAction Stop 
                }
           }
           else {
           Write-host "Warning: No action on below address object as it already exists in Panorama:" -ForegroundColor red
           Write-Output $currentAddressName
           "Warning: No action on below address object as it already exists in Panorama:" >> $errorlog
           $currentAddressName >> $errorlog
           }
            
        }
        
        catch
        {
           Write-host $AddressName 
           Write-Host "An error occurred on the above addressName:" -ForegroundColor red
           Write-output $_

           $AddressName >> $errorlog
           "An error occurred on the above addressName:" >> $errorlog
           $_ >> $errorlog


        }
        }

    }
