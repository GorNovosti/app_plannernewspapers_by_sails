define [
    'angular'
    'cs!./common/index'
    'cs!./home/index'
    'cs!./about/index'
    'cs!./newspapers/index'
    'cs!./pageedit/index' # редактор страницы(полосы)
    'cs!./releases/index'
    'cs!./users/index'
    'angular-bootstrap'
    'angular-resource'
    'angular-sanitize'
],(
    angular
    commonModule
    moduleAbout
    moduleHome
    module
    modulePageedit
    releasesModule
    usersModule
)->
    return angular.module( 'newspapersApp', [
        'ui.bootstrap'
        'ui.router'
        'ngResource'
        'ngSanitize'
        commonModule
        moduleAbout
        module
        moduleHome
        releasesModule
        usersModule
        modulePageedit
    ])
    .config(['$urlRouterProvider',($urlRouterProvider)->
        $urlRouterProvider.otherwise("/");
        #$routerProvider.when '/','/home'
    ])
    .run([->
        console.info 'run '
    ])