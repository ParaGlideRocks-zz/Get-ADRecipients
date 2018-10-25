#requires -version 2
<#
.SYNOPSIS
  Gather msExchRecipientTypeDetails using AD cmdlet and Exchange Snapin.

.DESCRIPTION
  In order to reduce time taken to collect data we'll leverage AD cmdlets.

.PARAMETER SearchBase
    This mandatory parameter specifies the distinguishedName of the OU where to start from data collection.

.INPUTS
  None

.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>

.NOTES
  Version:        1.0
  Author:         mnappa@microsoft.com, stefcas@microsoft.com
  Creation Date:  10/25/2018
  Purpose/Change: Initial script development
  
.EXAMPLE
  C:\PS> Get-ADRecipients -SearchBase "CN=Users,DC=contoso,DC=com"

  
    Description

    -----------

    This command collect Recipient Type Details in the specified Domain and OU.
#>

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------
# Parameter help description
Param(
    [Parameter(Mandatory=$true)]
    [string]$SearchBase
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#Dot Source required Function Libraries
. "C:\Scripts\Functions\Logging_Functions.ps1"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "<script_name>.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#

Function <FunctionName>{
  Param()
  
  Begin{
    Log-Write -LogPath $sLogFile -LineValue "<description of what is going on>..."
  }
  
  Process{
    Try{
      <code goes here>
    }
    
    Catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      Break
    }
  }
  
  End{
    If($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}

#>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
#Script Execution goes here
#Log-Finish -LogPath $sLogFile

$objects = Get-ADObject -ldapfilter "(msExchRecipientTypeDetails=*)" -SearchBase "OU=Users,DC=mailad,DC=it" -SearchScope Subtree -Properties *