$cats = @('residential','commercial','institutional','hospitality','master-plan','interiors')
$titles = @('Residential','Commercial','Institutional','Hospitality','Master Plan','Interiors')

for ($k=0; $k -lt $cats.Length; $k++) {
    $file = "c:\Users\Admin\Downloads\artchitec\listings\" + $cats[$k] + "\index.htm"
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $oldStr = "Designing Tomorrow" + [char]65533 + "s Cities"
    $newStr = $titles[$k]
    $c2 = $c.Replace($oldStr, $newStr)
    
    $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c2)
    [System.IO.File]::WriteAllBytes($file, $newBytes)
    Write-Output ("Done " + $cats[$k] + " - changed=" + ($c2 -ne $c))
}
