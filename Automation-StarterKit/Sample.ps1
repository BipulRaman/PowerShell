Param(
    [string] $ParametersFile = 'Sample.Params.json'
)

# Import PowerShell Logging Module
Import-Module .\PSLoggingModule.psm1 -Force

$ParametersFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateParametersFile))
$ParametersJson = (Get-Content -LiteralPath $ParametersFile) -join "`n" | ConvertFrom-Json

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

$SampleData = Get-SampleData -Param1 $ParametersJson.ParamOne -Param2 $ParametersJson.ParamTwo
Write-DataValue -Param $SampleData