#Function Definition
function AboutMe {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Name,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$Location
    )
    
    Write-Host I am $Name and I live in $Location
    #Write your logic
}

#Function Calling
AboutMe -Name "Bipul" -Location "Bangalore"