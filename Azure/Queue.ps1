# Set the amount of time you want to entry to be invisible after read from the queue
# If it is not deleted by the end of this time, it will show up in the queue again
$invisibleTimeout = [System.TimeSpan]::FromSeconds(10)
$queueName = "mailbox-sequence"
$queueConnectionString = ""

$queueContext = New-AzStorageContext -ConnectionString $queueConnectionString
$queue = Get-AzStorageQueue -Name $queueName -Context $queueContext

$queueMessage = $queue.CloudQueue.GetMessageAsync($invisibleTimeout,$null,$null)

if($null -eq $queueMessage.Result){
    Write-Host NULL
}
else{
    Write-Host $queueMessage.Result.AsString
    $queue.CloudQueue.DeleteMessageAsync($queueMessage.Result.Id,$queueMessage.Result.popReceipt)
}