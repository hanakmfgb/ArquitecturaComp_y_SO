
get-service | 
foreach-object { 
if ($_.status -eq 'stopped') 
{
    write-host -f magenta $_.name $_.status
    }   
else 
{ 
   write-host -f yellow $_.name $_.status
    }
}
