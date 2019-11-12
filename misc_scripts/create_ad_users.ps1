1..2 | % { $fname=(gc .\firstnames.txt | Get-Random -Count 1); $lname=(gc .\lastnames.txt | Get-Random -Count 1); $passwd=(gc .\pass.txt | Get-Random -Count 1); echo $fname"."$lname":"$passwd; net user /domain /add $fname.$lname $passwd }

