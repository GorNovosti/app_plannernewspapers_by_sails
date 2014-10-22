/**
 * bootstraps angular onto the window.document node
 * 
 */

define(['domReady!', 'angular', 'cs!app','sails.io'], function (document, ng, app) {
       
    return ng.bootstrap(document.getElementsByTagName('html'), [app['name'],
        function () {
            ng.element(document).find('html').addClass('ng-app');
        }
    ]);
});
