#Prerequisite Module : Az
#Install-Module -Name Az -AllowClobber

# Set the amount of time you want to entry to be invisible after read from the queue.
# If it is not deleted by the end of this time, it will show up in the queue again
$invisibleTimeout = [System.TimeSpan]::FromSeconds(10)
# Azure Storage Queue Name
$queueName = "mailbox-sequence"
# Azure Storage Queue Connection String
$queueConnectionString = ""

#Function to get message from Azure Storage Queue
Function Get-QueueMessage {  
    param (
        [Parameter(Mandatory = $true)]
        [psobject]$queueName,
        [Parameter(Mandatory = $true)]
        [psobject]$queueConnectionString
    )  
    $invisibleTimeout = [System.TimeSpan]::FromSeconds(10)
    $queueContext = New-AzStorageContext -ConnectionString $queueConnectionString
    $queue = Get-AzStorageQueue -Name $queueName -Context $queueContext
    $queueMessage = $queue.CloudQueue.GetMessageAsync($invisibleTimeout, $null, $null)

    if ($null -ne $queueMessage.Result) {
        $queue.CloudQueue.DeleteMessageAsync($queueMessage.Result.Id, $queueMessage.Result.popReceipt)
        Return $queueMessage.Result.AsString
    }
    else {
        Write-Host "No Message at Queue !"
        Return $null      
    }     
}

#Function to add message to Azure Storage Queue
Function New-QueueMessage {  
    param (
        [Parameter(Mandatory = $true)]
        [psobject]$queueName,
        [Parameter(Mandatory = $true)]
        [psobject]$queueConnectionString,
        [Parameter(Mandatory = $true)]
        [psobject]$newMessage
    )
    $queueContext = New-AzStorageContext -ConnectionString $queueConnectionString
    $queue = Get-AzStorageQueue -Name $queueName -Context $queueContext
    
    if ($null -ne $newMessage) {
        $queueMessage = New-Object -TypeName "Microsoft.Azure.Storage.Queue.CloudQueueMessage,$($queue.CloudQueue.GetType().Assembly.FullName)" -ArgumentList $newMessage
        $queue.CloudQueue.AddMessageAsync($QueueMessage)
        Write-Host "Message Added to Queue !"
    }    
}

# Calling functions to perform operations.
New-QueueMessage -queueName $queueName -queueConnectionString $queueConnectionString -newMessage "This is Bipul"
Get-QueueMessage -queueName $queueName -queueConnectionString $queueConnectionString