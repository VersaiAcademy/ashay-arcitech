$file = 'c:\Users\Admin\Downloads\artchitec\index.htm'
$lines = [System.IO.File]::ReadAllLines($file, [System.Text.Encoding]::UTF8)

# Find the closing </div> of gallery (line after last item, around line 4455)
# Find line with "item urban tall" (last item) and the next </div>
$galleryCloseIdx = -1
for ($i = 4450; $i -lt 4470; $i++) {
    if ($lines[$i] -match '^\s*</div>\s*$' -and $lines[$i-1] -match 'item urban tall') {
        $galleryCloseIdx = $i
        break
    }
}

if ($galleryCloseIdx -eq -1) {
    # fallback: find </div> after line 4454
    for ($i = 4454; $i -lt 4470; $i++) {
        if ($lines[$i] -match '^\s*</div>\s*$') {
            $galleryCloseIdx = $i
            break
        }
    }
}

Write-Host "Gallery close div at line: $($galleryCloseIdx + 1)"

# Insert Load More button after gallery closing div
$loadMoreHtml = @'
										<div class="gallery-load-more-wrapper">
											<button id="gallery-load-more" class="gallery-load-more-btn">
												<span class="load-more-text">Load More</span>
												<span class="load-more-icon">&#8595;</span>
											</button>
										</div>
'@

$newLines = [System.Collections.Generic.List[string]]::new()
for ($i = 0; $i -lt $lines.Length; $i++) {
    $newLines.Add($lines[$i])
    if ($i -eq $galleryCloseIdx) {
        $newLines.Add($loadMoreHtml)
    }
}

[System.IO.File]::WriteAllLines($file, $newLines.ToArray(), [System.Text.Encoding]::UTF8)
Write-Host "Load More button added"
