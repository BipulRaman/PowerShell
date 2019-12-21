<#
.Synopsis
   Script to Create Self Signed Certificate.
.DESCRIPTION
   Script to Create Self Signed X.509 Certificate and add to trusted root. This certificate can be used for certificate based authnetication in Azure App Registration.
   This Script has been released under the MIT (OSI) License as per the LICENSE file stored here: https://github.com/BipulRaman/PowerShell/blob/master/LICENSE
.NOTES
   Created by: @BipulRaman
   Modified by: @BipulRaman
   Modified: April 5, 2019
.EXAMPLE
    # How to use: 
    Run the script in PowerShell ISE in Admin mode.
#>

Param(
    [string]$FriendlyName = "Sample Certificate for XYZ",
    [string]$DnsName = "Sample Cert",
    [string]$Subject = "CN=SAMPLE",
    [string]$ValidFrom = "04/04/2019",
    [string]$ValidUntill = "12/31/2021",
    [string]$CerFilePath = "D:\Cert\Sample.cer",
    [string]$PfxFilePath = "D:\Cert\Sample.pfx",
    [SecureString]$SecurePassword
)

# Read password from console
$SecurePassword = Read-Host "Enter Password for Certificate" -AsSecureString

# Create Certificate
$Cert = New-SelfSignedCertificate -FriendlyName $FriendlyName -DnsName $DnsName -Subject $Subject -NotBefore $ValidFrom -NotAfter $ValidUntill -KeyExportPolicy Exportable -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -CertStoreLocation "Cert:\LocalMachine\My"

#Generate .pfx
Export-PfxCertificate -Cert $Cert -FilePath $PfxFilePath -Password $SecurePassword

#Export to .cer format
Export-Certificate -Type CERT -Cert $Cert -FilePath $CerFilePath

# Add Certificate to trusted root
$cert = (Get-ChildItem -Path $CerFilePath)
$cert | Import-Certificate -CertStoreLocation cert:\CurrentUser\Root

Write-Host Task Completed ! -ForegroundColor Green
