$root = 'C:\Users\Admin\Downloads\artchitec'
Get-ChildItem -Path $root -Recurse -Include '*.htm','*.html' | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    if ($content -match 'cropped-fav-icon') {
        $rel = $_.FullName.Substring($root.Length + 1)
        $depth = ($rel.Split('\').Count - 1)
        $prefix = '../' * $depth
        $favPath = $prefix + 'wp-content/themes/lumoria/assets/images/favicon.ico'
        $newFavLinks = "`t<link rel=`"icon`" href=`"$favPath`" type=`"image/x-icon`">`r`n`t<link rel=`"shortcut icon`" href=`"$favPath`" type=`"image/x-icon`">"
        $pattern = '(?s)[ \t]*<link rel="icon" href="[^"]*cropped-fav-icon-32x32[^"]*"[^>]*>\r?\n[ \t]*<link rel="icon" href="[^"]*cropped-fav-icon-192x192[^"]*"[^>]*>\r?\n[ \t]*<link rel="apple-touch-icon" href="[^"]*cropped-fav-icon-180x180[^"]*"[^>]*>\r?\n[ \t]*<meta name="msapplication-TileImage"[^\n]*\r?\n[ \t]*[^\n]*>'
        $newContent = [regex]::Replace($content, $pattern, $newFavLinks)
        if ($newContent -ne $content) {
            [System.IO.File]::WriteAllText($_.FullName, $newContent, [System.Text.Encoding]::UTF8)
            Write-Host "Updated: $($_.Name) ($rel)"
        } else {
            Write-Host "SKIPPED: $rel"
        }
    }
}
Write-Host "Done."
