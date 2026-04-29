$allPages = Get-ChildItem 'c:\Users\Admin\Downloads\artchitec' -Recurse -Filter 'index.htm'
$count = 0

foreach ($p in $allPages) {
    $bytes = [System.IO.File]::ReadAllBytes($p.FullName)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)
    $orig = $c

    # Remove Portfolio Details li - using regex to handle any whitespace/tabs
    $c = [regex]::Replace($c, '<li[^>]*menu-item-1234[^>]*>\s*<a[^>]*listings/designing-tomorrows-cities/index\.htm[^>]*><span[^>]*>Portfolio\s*Details</span></a></li>\s*', '')

    if ($c -ne $orig) {
        $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
        [System.IO.File]::WriteAllBytes($p.FullName, $newBytes)
        $count++
        Write-Host "Updated: $($p.Name) in $($p.DirectoryName.Split('\')[-1])"
    }
}
Write-Host "Total updated: $count"
