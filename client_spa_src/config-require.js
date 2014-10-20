/**
 * Configuration RequireJS 
 */
if (typeof define !== 'function') {
    // to be able to require file from node
    var define = require('amdefine')(module);
}
//window.name = 'NG_DEFER_BOOTSTRAP!';
define({
    // Here paths are set relative to `/source/js` folder
    baseUrl: "/spa/app",
    paths: {
        'cs': './../../vendors/require-cs/cs',
        'coffee-script': '../../vendors/coffeescript/extras/coffee-script',
        'text': '../../vendors/requirejs-text/text',
        'angular': '../../vendors/angular/angular',//"https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min",
        'angular-animate': '../../vendors/angular-animate/angular-animate',
        //'angular': '//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular',
        'angular-resource': '../../vendors/angular-resource/angular-resource',
        'angular-sails': '../../vendors/angular-sails/dist/angular-sails',
        'angular-ui-router': '../../vendors/angular-ui-router/release/angular-ui-router',
        'angular-ui-router.stateHalper': '../../vendors/angular-ui-router.stateHelper/statehelper',
        'angular-bootstrap': '../../vendors/angular-bootstrap/ui-bootstrap-tpls.min',
        'domReady': '../../vendors/domReady/domReady',
        //'socket.io': '../../socket.io', //'http://127.0.0.1:1337/socket.io.js' ,//'../../socket.io',
        //'sails.io': '../../js/dependencies/sails.io'// 'http://127.0.0.1:1337/js/dependencies/sails.io' //'../dependencies/sails.io'
        'socket.io': 'http://127.0.0.1:1337/socket.io.js', //'../../socket.io',
        'sails.io': 'http://127.0.0.1:1337/js/dependencies/sails.io', //'../dependencies/sails.io'
        'ng-table': '../../vendors/ng-table/ng-table',
        'angularjs-toaster': '../../vendors/AngularJS-Toaster/toaster',
        'angular-dialog-service': '../../vendors/angular-dialog-service/dist/dialogs.min',
        'angular-translate': '../../vendors/angular-translate/angular-translate',
        'angular-sanitize': '../../vendors/angular-sanitize/angular-sanitize',
        'dialogs-translation': '../../vendors/angular-dialog-service/dist/dialogs-default-translations.min',
        'lodash': '../../vendors/lodash/dist/lodash',
        'angular-local-storage': '../../vendors/angular-local-storage/dist/angular-local-storage',
        'angular-bootstrap-colorpicker': '../../vendors/angular-bootstrap-colorpicker/js/bootstrap-colorpicker-module',
    },
    shim: {
        'angular': {
            'exports': 'angular',
            deps: ['lodash']
        },
        'lodash': {
            exports: ['_']
        },
        'angular-resource': {
            deps: ['angular']
        },
        'angular-sails': {
            deps: ['sails.io', 'angular']
        },
        'angular-ui-router': {
            deps: ['angular']
        },
        'angular-ui-router.stateHalper': {
            deps: ['angular-ui-router']
        },
        'angular-bootstrap': {
            deps: ['angular']
        },
        'ng-table': {
            deps: ['angular']
        },
        'angular-animate': {
            deps: ['angular']
        },
        'angularjs-toaster': {
            deps: ['angular-animate']
        },
        'jQuery': {
            'exports': 'jQuery'
        },
        'socket.io': {
            'exports': 'io'
        },
        'sails.io': {
            'deps': ['socket.io'],
            'exports': 'io'
        },
        'angular-dialog-service': {
            deps: ['angular', 'angular-sanitize', 'dialogs-translation']
        },
        'angular-translate': {
            deps: ['angular']
        },
        'angular-sanitize': {
            deps: ['angular']
        },
        'dialogs-translation': {
            deps: ['angular', 'angular-translate']
        },
        'angular-local-storage': {
            deps: ['angular']
        },
        'angular-bootstrap-colorpicker':{
             deps: ['angular']
         }
    }
    //,deps:['sails.io']
});

