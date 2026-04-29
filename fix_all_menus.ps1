$allPages = Get-ChildItem 'c:\Users\Admin\Downloads\artchitec' -Recurse -Filter 'index.htm'

foreach ($p in $allPages) {
    $bytes = [System.IO.File]::ReadAllBytes($p.FullName)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)
    $orig = $c

    # Determine relative prefix based on depth
    $rel = $p.FullName.Replace('c:\Users\Admin\Downloads\artchitec\', '')
    $depth = ($rel.Split('\').Count - 1)
    
    if ($depth -eq 1) { $prefix = "" }
    elseif ($depth -eq 2) { $prefix = "../" }
    elseif ($depth -eq 3) { $prefix = "../../" }
    else { $prefix = "../../" }

    # Find what prefix is currently used for listings links in this file
    # We look for the Residential link pattern and replace all 6 category links
    
    # Pattern: href="[prefix]listings/designing-tomorrows-cities/index.htm"><span data-text="%1$s">Residential
    # Replace with correct category URLs
    
    $cats = @(
        @{name="Residential"; slug="residential"},
        @{name="Commercial"; slug="commercial"},
        @{name="Institutional"; slug="institutional"},
        @{name="Hospitality"; slug="hospitality"},
        @{name="Master Plan"; slug="master-plan"},
        @{name="Interiors"; slug="interiors"}
    )

    foreach ($cat in $cats) {
        # Try all possible prefixes
        foreach ($pre in @("", "../", "../../", "/")) {
            $oldHref = $pre + "listings/designing-tomorrows-cities/index.htm"
            $newHref = $pre + "listings/" + $cat.slug + "/index.htm"
            # Only replace when followed by the category name span
            $oldStr = $oldHref + '"><span' + [char]13 + [char]10
            # Use simple contains check first
            if ($c.Contains($oldHref + '"><span')) {
                # Find all occurrences with this category name nearby
                $idx = 0
                while ($true) {
                    $pos = $c.IndexOf($oldHref + '"><span', $idx)
                    if ($pos -lt 0) { break }
                    # Check if category name appears within next 200 chars
                    $snippet = $c.Substring($pos, [Math]::Min(200, $c.Length - $pos))
                    if ($snippet -match ('>' + [regex]::Escape($cat.name) + '<')) {
                        $c = $c.Substring(0, $pos) + $newHref + $c.Substring($pos + $oldHref.Length)
                        break
                    }
                    $idx = $pos + 1
                }
            }
        }
    }

    if ($c -ne $orig) {
        $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
        [System.IO.File]::WriteAllBytes($p.FullName, $newBytes)
        Write-Host "Updated: $($p.FullName)"
    }
}
Write-Host "All done"
