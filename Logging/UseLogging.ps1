# Import PowerShell Logging Module
Import-Module .\PSLoggingModule.psm1 -Force

# Sample Implementation of logging
Write-Log -Message 'Script Started' -Level Info -Path D:\Script.log
Write-Log -Message 'Script has error' -Level Error -Path D:\Script.log

# If Level not defined, the default level will be Info
Write-Log -Message 'Script Started' 

# If path not defined, the default path of log will be '.\PowerShellLog.log'
Write-Log -Message 'Script has error' -Level Error