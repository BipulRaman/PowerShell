<#
.Synopsis
.DESCRIPTION
   Script to regenerate 'n' number of duplicate files from given sample file. This script can be used to generate high volume of dummy data for testing purposes and other similar scenarios.
   This Script has been released under the MIT (OSI) License as per the LICENSE file stored here: https://github.com/BipulRaman/PowerShell/blob/master/LICENSE
.NOTES
   Created by: @BipulRaman
   Modified by: @BipulRaman
   Modified: Sepetember 7, 2019
.EXAMPLE
    # How to use: 
    Run the script in PowerShell ISE in Admin mode.
#>

Param(    
    [string] $SourceFolderPath = "C:\Sample\SAMPLE\",
    [string] $TargetFolderPath = "C:\Sample\Sample10GB\"
)

Write-Host (Get-Date) Starting Operation...

# Function to create desired set of duplicate files from a sample file.
Function New-SampleFiles {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$SourceFolder,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$TargetFolder,
        [Parameter(Mandatory = $true, Position = 3)]
        [string]$SampleFile,
        [Parameter(Mandatory = $true, Position = 4)]
        [int]$TargetCount,
        [Parameter(Mandatory = $true, Position = 5)]
        [string]$OutputPrefix,
        [Parameter(Mandatory = $true, Position = 6)]
        [string]$FileExtension
    )  
    
    for ($i = 1; $i -le $TargetCount; $i++) {
        try {
            $SourceFile = $SourceFolder + $SampleFile
            $Suffix = "{0:000000}" -f $i
            Write-Host (Get-Date) Creating -- $OutputPrefix $Suffix
            $TargetFile = $TargetFolder + $OutputPrefix + $Suffix + "." + $FileExtension
            Copy-Item $SourceFile -Destination $TargetFile
        }
        catch {     
            Write-Host $_.Message       
        }  
    }    
}

# Generate set of DOCX files from given sample (Modify or comment as per your requirement)
New-SampleFiles -SourceFolder $SourceFolderPath -TargetFolder $TargetFolderPath -SampleFile "SAMPLE.docx" -TargetCount 203 -OutputPrefix "DOCX" -FileExtension "docx"

# Generate set of XLSX files from given sample (Modify or comment as per your requirement)
New-SampleFiles -SourceFolder $SourceFolderPath -TargetFolder $TargetFolderPath -SampleFile "SAMPLE.xlsx" -TargetCount 203 -OutputPrefix "XLSX" -FileExtension "xlsx"

# Generate set of PDF files from given sample (Modify or comment as per your requirement)
New-SampleFiles -SourceFolder $SourceFolderPath -TargetFolder $TargetFolderPath -SampleFile "SAMPLE.pdf" -TargetCount 203 -OutputPrefix "PDF" -FileExtension "pdf"

# Generate set of PPTX files from given sample (Modify or comment as per your requirement)
New-SampleFiles -SourceFolder $SourceFolderPath -TargetFolder $TargetFolderPath -SampleFile "SAMPLE.pptx" -TargetCount 203 -OutputPrefix "PPTX" -FileExtension "pptx"

# Generate set of MPP files from given sample (Modify or comment as per your requirement)
New-SampleFiles -SourceFolder $SourceFolderPath -TargetFolder $TargetFolderPath -SampleFile "SAMPLE.mpp" -TargetCount 203 -OutputPrefix "MPP" -FileExtension "mpp"


Write-Host (Get-Date) Operation Completed !!