/**
 * Configuration RequireJS 
 */
  
requirejs.config({
    // Here paths are set relative to `/source/js` folder
    baseUrl: "src/src_client",
    
    paths: {
        'cs': '../../vendors/require-cs/cs',
        'coffee-script': '../../vendors/coffeescript/extras/coffee-script',
        'text': '../../vendors/requirejs-text/text',
        'angular': '../../vendors/angular/angular',
        //'angular': '//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular',
        'angular-resource': '../../vendors/angular-resource',
        'angular-ui-router': '../../vendors/angular-ui-router/release/angular-ui-router',
        'angular-ui-router.stateHalper': '../../vendors/angular-ui-router.stateHelper/statehelper',
        
        'domReady': './../../vendors/domReady/domReady',
        'socket.io': 'http://127.0.0.1:1337/socket.io.js' ,//'../../socket.io',
        'sails.io':  'http://127.0.0.1:1337/js/dependencies/sails.io' //'../dependencies/sails.io'
        
        ,'page/app':'../src_client/newspapers/index'
    },
    shim: {
        'angular': {
            'exports': 'angular'
        },
        'angular-resource': ['angular'],
        'angular-ui-router': {
            deps: ['angular']
        },
        'angular-ui-router.stateHalper': {
            deps: ['angular-ui-router']
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
        }
    }
});

