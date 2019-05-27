function GetRemoteLogonStatus ($computer = 'localhost') { 
if (Test-Connection $computer -Count 2 -Quiet) { 
    try { 
        $user = $null 
        $user = gwmi -Class win32_computersystem -ComputerName $computer | select -ExpandProperty username -ErrorAction Stop 
        } 
    catch { "Not logged on"; return } 
    try { 
        if ((Get-Process logonui -ComputerName $computer -ErrorAction Stop) -and ($user)) { 
            "Workstation locked by $user" 
            } 
        } 
    catch { if ($user) { "$user logged on" } } 
    } 
else { "$computer Offline" } 
}