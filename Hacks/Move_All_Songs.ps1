# Script to move all mp3 file from multiple nested folders to single folder. 
# By : Bipul Raman

#####################################################

## Global variables --- To be defined by user

# Source folder from where you need to pick songs
$SourceDir = "D:\All Songs"

# Target folder where you need to move all songs
$TargetDir = "D:\My Songs"

# Path and name of Log file
$LogFilePath = "D:\Logs\MoveSongs.log"

#####################################################

# Fuction for logging
function Write-Log {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias("LogContent")]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [Alias('LogPath')]
        [string]$Path,
        
        [Parameter(Mandatory = $false)]
        [ValidateSet("Error", "Warn", "Info")]
        [string]$Level = "Info",
        
        [Parameter(Mandatory = $false)]
        [switch]$NoClobber
    )

    Begin {
        # Set VerbosePreference to Continue so that verbose messages are displayed.
        $VerbosePreference = 'Continue'
    }
    Process {
        
        # If the file already exists and NoClobber was specified, do not write to the log.
        if ((Test-Path $Path) -AND $NoClobber) {
            Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name."
            Return
        }

        # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path.
        elseif (!(Test-Path $Path)) {
            Write-Verbose "Creating $Path."
            $NewLogFile = New-Item $Path -Force -ItemType File
        }

        else {
            # Nothing to see here yet.
        }

        # Format Date for our Log File
        $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # Write message to error, warning, or verbose pipeline and specify $LevelText
        switch ($Level) {
            'Error' {
                Write-Error $Message
                $LevelText = 'ERROR:'
            }
            'Warn' {
                Write-Warning $Message
                $LevelText = 'WARNING:'
            }
            'Info' {
                Write-Verbose $Message
                $LevelText = 'INFO:'
            }
        }
        
        # Write log entry to $Path
        "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append
    }
    End {
    }
}

# Function to move songs
function MoveSongs {
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$SourceDir,
        [Parameter(Mandatory = $true, Position = 2)]
        [string]$TargetDir
    )
    
    try {
        Get-ChildItem $SourceDir -Filter *.mp3 -Recurse | Foreach-Object {    
            $Source_File_Path = $_.FullName
            $Target_File_Path =  $TargetDir + "\" + $_.Name
            Write-Host Moving $Source_File_Path to Target folder -ForegroundColor Green
            Move-Item -Path $Source_File_Path -Destination $Target_File_Path -Force
            Write-Log -Message "Successfully moved - $Source_File_Path" -Level Info -Path $LogFilePath
        }        
    }
    catch {
        Write-Log -Message $_.Exception.Message -Level Error -Path $LogFilePath
    }
}


## Function Call

MoveSongs -SourceDir $SourceDir -TargetDir $TargetDir
Write-Host Script execution Completed. Please verify logs !! -ForegroundColor Blue
