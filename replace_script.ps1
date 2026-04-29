$file = 'c:\Users\Admin\Downloads\artchitec\index.htm'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$oldScript = @'
<script>


					const buttons = document.querySelectorAll('.filter-buttons button');

					const items = document.querySelectorAll('.gallery .item');




					buttons.forEach(button => {
						button.addEventListener('click', () => {
							// Remove active class from all buttons
							buttons.forEach(btn => btn.classList.remove('active'));
							// Add active class to clicked button

							button.classList.add('active');




							const filter = button.getAttribute('data-filter');




							console.log('Filter clicked:', filter); // Debug log




							// Filter items with smooth animation

							items.forEach((item, index) => {


								// Reset any previous timeouts

								setTimeout(() => {
									if (filter === 'all') {
										// Show all items

										item.classList.remove('hide');


										item.style.display = 'block';


									} else if (item.classList.contains(filter)) {


										// Show matching items


										item.classList.remove('hide');


										item.style.display = 'block';

									} else {

										// Hide non-matching items


										item.classList.add('hide');


										// Use timeout to hide after animation


										setTimeout(() => {


											if (item.classList.contains('hide')) {

												item.style.display = 'none';

											}

										}, 400);

									}


								}, index * 30); // Staggered animation

							});

						});

					});




					// Initialize gallery
					document.addEventListener('DOMContentLoaded', function () {
						// Show all items initially
						items.forEach(item => {
							item.style.display = 'block';

							item.classList.remove('hide');

						});



						// Debug: Log all items and their classes


						console.log('Gallery items:', items);


						items.forEach((item, index) => {


							console.log(`Item ${index}:`, item.className);

						});


					});

				</script>
'@

$newScript = @'
<script>
					const INITIAL_SHOW = 8;
					let currentFilter = 'all';
					let showAll = false;

					const buttons = document.querySelectorAll('.filter-buttons button');
					const allItems = Array.from(document.querySelectorAll('.gallery .item'));
					const loadMoreBtn = document.getElementById('gallery-load-more');

					function getFilteredItems() {
						if (currentFilter === 'all') return allItems;
						return allItems.filter(item => item.classList.contains(currentFilter));
					}

					function renderGallery() {
						const filtered = getFilteredItems();
						allItems.forEach(item => { item.style.display = 'none'; item.classList.remove('hide'); });
						const toShow = showAll ? filtered : filtered.slice(0, INITIAL_SHOW);
						toShow.forEach((item, i) => {
							setTimeout(() => { item.style.display = 'block'; }, i * 30);
						});
						if (filtered.length > INITIAL_SHOW && !showAll) {
							loadMoreBtn.style.display = 'inline-flex';
							loadMoreBtn.querySelector('.load-more-text').textContent = 'Load More (' + (filtered.length - INITIAL_SHOW) + ' more)';
						} else {
							loadMoreBtn.style.display = 'none';
						}
					}

					buttons.forEach(button => {
						button.addEventListener('click', () => {
							buttons.forEach(btn => btn.classList.remove('active'));
							button.classList.add('active');
							currentFilter = button.getAttribute('data-filter');
							showAll = false;
							renderGallery();
						});
					});

					loadMoreBtn.addEventListener('click', () => {
						showAll = true;
						renderGallery();
					});

					document.addEventListener('DOMContentLoaded', renderGallery);
					renderGallery();
				</script>
'@

$content = $content.Replace($oldScript, $newScript)
[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Script replaced: $($content.Contains('INITIAL_SHOW'))"
