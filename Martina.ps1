Function Set-InternetProxy
{
    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String[]]$Proxy,

        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$acs
                
    )

    Begin
    {

            $regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
        
    }
    
    Process
    {
        
        Set-ItemProperty -path $regKey ProxyEnable -value 1

        Set-ItemProperty -path $regKey ProxyServer -value $proxy
                            
        if($acs) 
        {            
            
                 Set-ItemProperty -path $regKey AutoConfigURL -Value $acs          
        }

    } 
    
    End
    {

        Write-Output "Proxy is now enabled"

        Write-Output "Proxy Server : $proxy"

        if ($acs)
        {
            
            Write-Output "Automatic Configuration Script : $acs"

        }
        else
        {
            
            Write-Output "Automatic Configuration Script : Not Defined"

        }
    }
}

$csv = Import-Csv D:\Martina\proxy.csv -Header @("IP","port")

foreach ($item in $csv) {
	Write-Output "$item.IP:$item.port"
    
#	Set-InternetProxy -proxy "$line.IP:$line.port"
	
	$ie = New-Object -ComObject 'internetExplorer.Application'
	$ie.Visible= $true
	$ie.Navigate("https://maminkaroku.maminka.cz/soutez/maminkaroku/2018/profil/255/martina")

	while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}  

} 

#$token = $ie.Document.getElementById("tokenval")
#Write-Host $token.value
#$url = "https://maminkaroku.maminka.cz/captcha/$token.value"
#$wc = New-Object System.Net.WebClient
#$wc.DownloadFile($url, "D:\test.jpg")

#$Link=$ie.Document.getElementsByTagName("input") | where-object {$_.className -eq "voteButton button"}







