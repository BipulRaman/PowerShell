<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.PARAMETER ParametersFile
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Created by: Bipul Raman @BipulRaman
  Modified by: Bipul Raman @BipulRaman
  Modified: 12/22/2018 02:26 PM IST
  Purpose/Change: Initial script development
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

#-------------------[PARAMETERS]-------------------

Param(
    [string] $ParametersFilePath = 'Sample.Params.json'
)

#-------------------[INITIALISATIONS]-------------------

# Import PowerShell Logging Module
Import-Module .\PSLoggingModule.psm1 -Force

$ParametersFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $ParametersFilePath))
$ParametersJson = (Get-Content -LiteralPath $ParametersFile) -join "`n" | ConvertFrom-Json

#-------------------[FUNCTIONS]-------------------

# Sample Function
Function Get-SampleData {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Param1,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$Param2
    )  
    
    try {
        Write-Log -Message "Inside Get-SampleData Function" -Level Info
        $FinalValue = $Param1 +"," + $Param2
        Return $FinalValue
    }
    catch {
        Write-Log -Message $_.Exception.Message -Level Error
        Return $null
    }  
}

#Function to Write Value in Terminal
Function Write-DataValue {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Param
    )
    
    if($Param){
        Write-Log -Message "The value is $Param" -Level Info  
    }
    else{
        Write-Log -Message "The value is NULL" -Level Info
    }
}

#-------------------[EXECUTION]-------------------

$SampleData = Get-SampleData -Param1 $ParametersJson.ParamOne -Param2 $ParametersJson.ParamTwo
Write-DataValue -Param $SampleData