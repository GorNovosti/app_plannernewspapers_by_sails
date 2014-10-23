define [
    'angular'
    'cs!./d3test/index'
    'angular-ui-router'
    'angular-bootstrap'
    'angular-resource'
    'angular-sanitize'
],(
    angular
    module
)->
    return angular.module( 'newspapersApp', [
        'ui.bootstrap'
        'ui.router'
        'ngResource'
        'ngSanitize'
        module['name']

    ])
    .config(['$urlRouterProvider',($urlRouterProvider)->
        $urlRouterProvider.otherwise("/#{ module['name']}");
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

