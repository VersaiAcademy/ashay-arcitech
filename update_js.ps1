$file = 'c:\Users\Admin\Downloads\artchitec\index.htm'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Replace old script block - find by unique markers
$scriptStart = $content.IndexOf('<script>' + "`r`n`r`n`r`n`t`t`t`t`t`t`t`t`t`t`t`tconst buttons = document.querySelectorAll")
if ($scriptStart -eq -1) {
    $scriptStart = $content.IndexOf("<script>`r`n`r`n`r`n`t`t`t`t`t`t`t`t`t`t`t`tconst buttons")
}
Write-Host "Script start: $scriptStart"

$scriptEnd = $content.IndexOf('</script>', $scriptStart)
Write-Host "Script end: $scriptEnd"

if ($scriptStart -gt 0 -and $scriptEnd -gt 0) {
    $newScript = @'
<script>
					var INITIAL_SHOW = 8;
					var currentFilter = 'all';
					var showAll = false;

					function getFilteredItems() {
						var allItems = Array.from(document.querySelectorAll('.gallery .item'));
						if (currentFilter === 'all') return allItems;
						return allItems.filter(function(item) { return item.classList.contains(currentFilter); });
					}

					function renderGallery() {
						var allItems = Array.from(document.querySelectorAll('.gallery .item'));
						var loadMoreBtn = document.getElementById('gallery-load-more');
						var filtered = getFilteredItems();
						allItems.forEach(function(item) { item.style.display = 'none'; });
						var toShow = showAll ? filtered : filtered.slice(0, INITIAL_SHOW);
						toShow.forEach(function(item, i) {
							setTimeout(function() { item.style.display = 'block'; }, i * 30);
						});
						if (loadMoreBtn) {
							if (filtered.length > INITIAL_SHOW && !showAll) {
								loadMoreBtn.parentElement.style.display = 'flex';
								loadMoreBtn.querySelector('.load-more-text').textContent = 'Load More (' + (filtered.length - INITIAL_SHOW) + ' more)';
							} else {
								loadMoreBtn.parentElement.style.display = 'none';
							}
						}
					}

					document.addEventListener('DOMContentLoaded', function() {
						var buttons = document.querySelectorAll('.filter-buttons button');
						var loadMoreBtn = document.getElementById('gallery-load-more');

						buttons.forEach(function(button) {
							button.addEventListener('click', function() {
								buttons.forEach(function(btn) { btn.classList.remove('active'); });
								button.classList.add('active');
								currentFilter = button.getAttribute('data-filter');
								showAll = false;
								renderGallery();
							});
						});

						if (loadMoreBtn) {
							loadMoreBtn.addEventListener('click', function() {
								showAll = true;
								renderGallery();
							});
						}

						renderGallery();
					});
				</script>
'@
    $content = $content.Substring(0, $scriptStart) + $newScript + $content.Substring($scriptEnd + 9)
    Write-Host "Script replaced successfully"
} else {
    Write-Host "Script markers not found, trying alternate search..."
    # Find script by looking for const buttons line
    $idx = $content.IndexOf("const buttons = document.querySelectorAll('.filter-buttons button')")
    Write-Host "const buttons at: $idx"
}

# Add Load More CSS before </style> in the gallery style block
$cssToAdd = @'

					/* Load More Button */
					.gallery-load-more-wrapper {
						display: flex;
						justify-content: center;
						margin-top: 40px;
					}
					.gallery-load-more-btn {
						display: inline-flex;
						align-items: center;
						gap: 10px;
						padding: 14px 35px;
						background: #332886;
						color: #fff;
						border: none;
						border-radius: 30px;
						font-size: 15px;
						font-weight: 600;
						cursor: pointer;
						box-shadow: 0 4px 20px rgba(51,40,134,0.3);
						transition: all 0.3s ease;
						letter-spacing: 0.5px;
					}
					.gallery-load-more-btn:hover {
						background: #251f6b;
						transform: translateY(-3px);
						box-shadow: 0 8px 25px rgba(51,40,134,0.4);
					}
					.gallery-load-more-btn .load-more-icon {
						font-size: 18px;
						animation: bounce 1.5s infinite;
					}
					@keyframes bounce {
						0%, 100% { transform: translateY(0); }
						50% { transform: translateY(4px); }
					}
'@

# Find the closing </style> of the gallery style block (after .gallery .item:nth-child(8))
$styleCloseIdx = $content.IndexOf('/* Smooth filtering animation */')
if ($styleCloseIdx -gt 0) {
    # Insert CSS before this comment
    $content = $content.Substring(0, $styleCloseIdx) + $cssToAdd + "`r`n`t`t`t`t`t`t`t`t`t`t`t`t" + $content.Substring($styleCloseIdx)
    Write-Host "CSS added"
}

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done"
