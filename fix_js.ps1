$file = 'c:\Users\Admin\Downloads\artchitec\index.htm'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Find the <script> tag just before "const buttons"
$constPos = $content.IndexOf("const buttons = document.querySelectorAll('.filter-buttons button')")
# Find the <script> opening before it
$scriptOpenPos = $content.LastIndexOf('<script>', $constPos)
# Find the </script> closing after it
$scriptClosePos = $content.IndexOf('</script>', $constPos)

Write-Host "Script open: $scriptOpenPos, Script close: $scriptClosePos"

$newScript = '<script>
					var INITIAL_SHOW = 8;
					var currentFilter = ''all'';
					var showAll = false;

					function getFilteredItems() {
						var allItems = Array.from(document.querySelectorAll(''.gallery .item''));
						if (currentFilter === ''all'') return allItems;
						return allItems.filter(function(item) { return item.classList.contains(currentFilter); });
					}

					function renderGallery() {
						var allItems = Array.from(document.querySelectorAll(''.gallery .item''));
						var loadMoreBtn = document.getElementById(''gallery-load-more'');
						var filtered = getFilteredItems();
						allItems.forEach(function(item) { item.style.display = ''none''; });
						var toShow = showAll ? filtered : filtered.slice(0, INITIAL_SHOW);
						toShow.forEach(function(item, i) {
							setTimeout(function() { item.style.display = ''block''; }, i * 30);
						});
						if (loadMoreBtn) {
							if (filtered.length > INITIAL_SHOW && !showAll) {
								loadMoreBtn.parentElement.style.display = ''flex'';
								loadMoreBtn.querySelector(''.load-more-text'').textContent = ''Load More ('' + (filtered.length - INITIAL_SHOW) + '' more)'';
							} else {
								loadMoreBtn.parentElement.style.display = ''none'';
							}
						}
					}

					document.addEventListener(''DOMContentLoaded'', function() {
						var buttons = document.querySelectorAll(''.filter-buttons button'');
						var loadMoreBtn = document.getElementById(''gallery-load-more'');

						buttons.forEach(function(button) {
							button.addEventListener(''click'', function() {
								buttons.forEach(function(btn) { btn.classList.remove(''active''); });
								button.classList.add(''active'');
								currentFilter = button.getAttribute(''data-filter'');
								showAll = false;
								renderGallery();
							});
						});

						if (loadMoreBtn) {
							loadMoreBtn.addEventListener(''click'', function() {
								showAll = true;
								renderGallery();
							});
						}

						renderGallery();
					});
				</script>'

$before = $content.Substring(0, $scriptOpenPos)
$after = $content.Substring($scriptClosePos + 9)
$content = $before + $newScript + $after

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "JS replaced. Verify: $($content.Contains('INITIAL_SHOW'))"
