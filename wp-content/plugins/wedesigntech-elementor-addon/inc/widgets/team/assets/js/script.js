(function ($) {
    const wdtTeamWidgetHandler = function ($scope, $) {
        const $teamHolderClick = $scope.find('.wdt-team-holder.wdt-rc-template-default.wdt-rc-template-click');
        const $teamHolderHover = $scope.find('.wdt-team-holder.wdt-rc-template-default.wdt-rc-template-hover');
        const toggleIconSVG = `
            <div class="wdt-team-icon-toggle"><span class="wdt-team-toggle">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path d="M18,8.5h-6.6v-7c0-0.8-0.6-1.5-1.4-1.5c-0.8,0-1.4,0.7-1.4,1.5v7H2c-0.8,0-1.4,0.7-1.4,1.5s0.6,1.5,1.4,1.5h6.6v7
                    c0,0.8,0.6,1.5,1.4,1.5c0.8,0,1.4-0.7,1.4-1.5v-7H18c0.8,0,1.4-0.7,1.4-1.5S18.8,8.5,18,8.5z"/>
              </svg>
            </span></div>
        `;

        if ($teamHolderClick.length) {
            $teamHolderClick.find('.wdt-social-icons-container').each(function () {
                const $container = $(this);
                if (!$container.find('.wdt-team-toggle').length) {
                    $container.append(toggleIconSVG);
                }
                $container.find('.wdt-team-toggle').on('click', function () {
                    $container.find('.wdt-social-icons-list').toggleClass('active');
                });
            });
        } else if ($teamHolderHover.length) {
            $teamHolderHover.find('.wdt-social-icons-container').each(function () {
                const $container = $(this);
                if (!$container.find('.wdt-team-toggle').length) {
                    $container.append(toggleIconSVG);
                }
                // Hover effects
                $container.on('mouseenter', function () {
                    $container.find('.wdt-social-icons-list').addClass('active');
                }).on('mouseleave', function () {
                    $container.find('.wdt-social-icons-list').removeClass('active');
                });
            });
        } else {
            console.warn('WDT Team Holder not found in the scope.');
        }
    };

    $(window).on('elementor/frontend/init', function () {
        elementorFrontend.hooks.addAction('frontend/element_ready/wdt-team.default', wdtTeamWidgetHandler);
    });

})(jQuery);
