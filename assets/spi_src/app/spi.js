/***
 *  
 */
define(['domReady!', 'angular', 'cs!./namespace', /*'sails.io',*/'cs!./index'], function (document, angular, namespace, /* io,*/ spi) {

    var app = angular.module('spi' + namespace, [spi]);
    app.config(['$locationProvider', function ($locationProvider) {
            $locationProvider.html5Mode(true);
        }
    ]);
    app.run([function(){
            console.warn('run');
    }]);
    console.log(app['name'], '--OK2- 4-', spi);
    try {
        return angular.bootstrap(
                document, [app['name'], function () {
//            var socket = io.connect('http://127.0.0.1:1337/');
//            socket.on('connect', function socketConnected(l) {
//                console.log('Socket is now connected',l);
//            });  
                        //   angular.element(document).find('html').addClass('ng-app');
                    }]);
    } catch (e) {
        console.error(e.stack || e.message || e);
    }
});