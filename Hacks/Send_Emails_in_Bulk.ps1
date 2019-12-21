# By: Bipul Raman | Created on Mar 6, 2016

$MailingList = Import-Csv E:\MailingList.csv

#SMTP Server and port may differ for different email service provider
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"

#Your email id and password
$Username = "email@gmail.com"
$Password = "Password"

#Iterating data from CSV mailing list and sending email to each person
foreach ( $person in $MailingList)
{
    $iName = $person.Name
    $iEmail =  $person.Email    
    $iAddress = $person.Address

    $to = $person.Email
    $cc = "other@domain.com"
    $subject = "Email Subject"
    $body = @" 

Hi $iName,

Your address is  : $iAddress

Regards,
Your Name  
                            
"@    
$attachment = "C:\test.txt"

    $message = New-Object System.Net.Mail.MailMessage
    $message.subject = $subject
    $message.body = $body
    $message.to.add($to)
    $message.cc.add($cc)
    $message.from = $username
    $message.attachments.add($attachment)

    $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
    $smtp.EnableSSL = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message)
    Write-Host Mail Sent to $iName
}
