$allPages = Get-ChildItem 'c:\Users\Admin\Downloads\artchitec' -Recurse -Filter 'index.htm'

foreach ($p in $allPages) {
    $bytes = [System.IO.File]::ReadAllBytes($p.FullName)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)
    $orig = $c

    # Pattern to remove - Portfolio Details menu item
    $pattern = '<li id="menu-item-1234"[^>]*class="menu-item[^"]*menu-item-1234[^"]*">\s*<a[^>]*href="[^"]*listings/designing-tomorrows-cities/index\.htm"[^>]*><span[^>]*>Portfolio\s*Details</span></a></li>'
    
    # Simple string replacement approach
    $toRemove = @(
        '<li id="menu-item-1234"' + [char]13 + [char]10 + '																				class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1234 menu-item-depth-1">' + [char]13 + [char]10 + '																				<a' + [char]13 + [char]10 + '																					href="listings/designing-tomorrows-cities/index.htm"><span' + [char]13 + [char]10 + '																						data-text="%1$s">Portfolio' + [char]13 + [char]10 + '																						Details</span></a></li>',
        '<li id="menu-item-1234"' + [char]13 + [char]10 + '																				class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1234 menu-item-depth-1">' + [char]13 + [char]10 + '																				<a' + [char]13 + [char]10 + '																					href="../listings/designing-tomorrows-cities/index.htm"><span' + [char]13 + [char]10 + '																						data-text="%1$s">Portfolio' + [char]13 + [char]10 + '																						Details</span></a></li>',
        '<li id="menu-item-1234"' + [char]13 + [char]10 + '																				class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1234 menu-item-depth-1">' + [char]13 + [char]10 + '																				<a' + [char]13 + [char]10 + '																					href="../../listings/designing-tomorrows-cities/index.htm"><span' + [char]13 + [char]10 + '																						data-text="%1$s">Portfolio' + [char]13 + [char]10 + '																						Details</span></a></li>',
        '<li id="menu-item-1234"' + [char]13 + [char]10 + '																				class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1234 menu-item-depth-1">' + [char]13 + [char]10 + '																				<a' + [char]13 + [char]10 + '																					href="/listings/designing-tomorrows-cities/index.htm"><span' + [char]13 + [char]10 + '																						data-text="%1$s">Portfolio' + [char]13 + [char]10 + '																						Details</span></a></li>'
    )

    foreach ($str in $toRemove) {
        if ($c.Contains($str)) {
            $c = $c.Replace($str, '')
            Write-Host "Removed from: $($p.FullName)"
        }
    }

    if ($c -ne $orig) {
        $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
        [System.IO.File]::WriteAllBytes($p.FullName, $newBytes)
    }
}
Write-Host "Done"
