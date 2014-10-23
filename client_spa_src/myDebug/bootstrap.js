/**
 * bootstraps angular onto the window.document node
 * //??https://github.com/StarterSquad/startersquad.com/blob/master/examples/angularjs-requirejs-2/js/bootstrap.js
 */

define(['domReady!', 'angular', 'cs!app'], function (document, ng, app) {
    return ng.bootstrap(document.getElementsByTagName('html'), [app['name'],
        function () {
            ng.element(document).find('html').addClass('ng-app');
        }
    ]);
});
