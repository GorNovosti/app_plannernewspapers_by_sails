define [
    'angular'
    'cs!./resizing/index'
    'angular-bootstrap'
    'angular-resource'
    'angular-sanitize'
],(
    angular

    moduleAbout

)->
    return angular.module( 'newspapersApp', [
        'ui.bootstrap'
        'ui.router'
        'ngResource'
        'ngSanitize'
        moduleAbout

    ])
    .config(['$urlRouterProvider',($urlRouterProvider)->
        $urlRouterProvider.otherwise("/resizing");
    ])
    .run(['$rootScope',($rootScope)->
        ## App stata
        $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->
            $rootScope.pageTitle = 'Deploy'
            if angular.isDefined toState.data
                if angular.isDefined toState.data.pageTitle
                    $rootScope.pageTitle = toState.data.pageTitle + ' | Planner'
        console.info 'run '
    ]) # http status 500

