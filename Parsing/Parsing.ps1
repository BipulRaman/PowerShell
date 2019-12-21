# JSON Parsing
$JsonData = (Get-Content '.\Sample-JSON.json') | ConvertFrom-Json
foreach($item in $JsonData){      
    Write-Host ID is $item.Id and Name is $item.Name
}

# CSV Parsing
$CsvData = Import-Csv  '.\Sample-CSV.csv'
foreach($item in $CsvData){      
    Write-Host ID is $item.Id and Name is $item.Name
}

# XML Parsing
$XmlData = [xml](Get-Content '.\Sample-XML.xml')
foreach($item in $XmlData.Folk.Dev){      
    Write-Host ID is $item.Id and Name is $item.Name
}