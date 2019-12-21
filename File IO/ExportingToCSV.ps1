$resultSet = @() | Export-Csv '.\output.csv' -NoTypeInformation

$newResultSet = New-Object PSObject -Property @{
    Id       = "1"
    Name     = "Bipul Raman"
    Location = "Bangalore"
}
$newResultSet | Export-Csv '.\output.csv' -Append -NoTypeInformation

$newResultSet1 = New-Object PSObject -Property @{
    Id       = "2"
    Name     = "Narendra Modi"
    Location = "New Delhi"
}
$newResultSet1 | Export-Csv '.\output.csv' -Append -NoTypeInformation

$newResultSet2 = New-Object PSObject -Property @{
    Id       = "3"
    Name     = "Laloo Prasad"
    Location = "Patna"
}
$newResultSet2 | Export-Csv '.\output.csv' -Append -NoTypeInformation