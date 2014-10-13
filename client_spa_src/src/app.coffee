define [
    'angular'
    'cs!./common/index'
    'cs!./home/index'
    'cs!./newspapers/index'
    'cs!./releases/index'
    'cs!./users/index'
    'angular-bootstrap'
    'angular-resource'
    'angular-sanitize'
],(
    angular
    commonModule
    moduleHome
    module
    releasesModule
    usersModule
)->
    return angular.module( 'newspapersApp', [
        'ui.bootstrap'
        'ui.router'
        'ngResource'
        'ngSanitize'
        commonModule
        module
        moduleHome
        releasesModule
        usersModule
    ])
    .config(['$urlRouterProvider',($urlRouterProvider)->
        $urlRouterProvider.otherwise("/");
        #$routerProvider.when '/','/home'
    ])
    .run([->
        console.info 'run '
    ])