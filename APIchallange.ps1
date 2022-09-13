#endpoints = (get-content "D:\Coding\Powershell\worldwide.json" -Raw) | ConvertFrom-Json

$endpoints = Invoke-WebRequest 'https://endpoints.office.com/endpoints/worldwide?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7' | ConvertFrom-Json
$droppedConnections = get-content "D:\Coding\Powershell\ipaddresses.txt"

#$droppedConnections= @()
#$droppedConnections = Read-Host "Please enter IP address of the dropped connection"

function checkips{
param(
     [Parameter()]
     [string]$ip
)

#$ip = Read-Host "Please enter ip address"
    $i=0
    $json = @()
    while([string]::IsNullOrWhiteSpace($endpoints[$i]) -eq $False){
        #[string]::IsNullOrWhiteSpace($endpoints[$i])

        if($endpoints[$i].ips -match $ip){
            write-host $endpoints[$i]
            $json += $endpoints[$i]         
        }else{
        } 
        $i++
    } 

    if (!$json){
        write-host $ip "is not on this list"

    }else {
    $   json | ConvertTo-Json | Out-File "D:\Coding\Powershell\$($ip).json" -append
    }
}

foreach($Connection in $droppedConnections){

    checkips($Connection) 

}


 












