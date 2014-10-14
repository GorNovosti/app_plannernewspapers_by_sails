define [
    'angular'
    'cs!./common/index'
    'cs!./home/index'
    'cs!./about/index'
    'cs!./newspapers/index'
    'cs!./pageedit/index' # редактор страницы(полосы)
    'cs!./releases/index'
    'cs!./users/index'
    'cs!./referencies/index' #
    'cs!./common/security/index'
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
    referenciesModule
    securityModule
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
        referenciesModule
        securityModule
    ])
    .config(['$urlRouterProvider',($urlRouterProvider)->
        $urlRouterProvider.otherwise("/");
        #$routerProvider.when '/','/home'
    ])
    .run(['$rootScope',($rootScope)->
        ## App stata
        $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->

            $rootScope.pageTitle = 'Planner newspaper'
            if angular.isDefined toState.data
                if angular.isDefined toState.data.pageTitle
                    $rootScope.pageTitle = toState.data.pageTitle + ' | Planner'
        console.info 'run '
    ]) # http status 500
    .config ['$httpProvider', ($httpProvider)->
        $httpProvider.interceptors.push(['$q', '$location', 'NotificationService',
            ($q, $location, NotificationService)->
                response: (response)->
                    if (response.status == 500)
                        NotificationService.error("Server error", response.data.message)

                    return response || $q.when(response)
                responseError: (rejection)->
                    if (rejection.status == 500)
                        console.log("Response Error 500", rejection)
                        if rejection.data?.summary?
                            NotificationService.error("Server error", rejection.data.summary)
                    return $q.reject(rejection)
        ])
    ]