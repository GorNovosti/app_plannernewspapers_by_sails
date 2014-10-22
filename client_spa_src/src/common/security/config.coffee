###
Module configuration
###
define [
    'cs!./namespace'
    'cs!./module'
    'cs!./statespace'         ## Configuration for ui-route state
    'cs!./controllers/LoginController'
], (namespace, module, statespace)->


    module.config ['$stateProvider', ($stateProvider)->
        ###
        Main configuration $stateProvider
        ###
        $stateProvider.state statespace.name,
            url: statespace.url
            #            views:
            #                "header@":
            #                    templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/header.tpl.html"
            #                "main@":
            templateUrl:"templates/#{namespace.replace /\.+/g, "/"}/signin_form.tpl.html" #"templates/#{namespace.replace /\.+/g, "/"}/index.tpl.html"
            controller: ['$scope', ($scope)->
                $scope.statespace = statespace
            ]
            data:
                titlePage: statespace.titlePage  ## Name for set title of page
    ]
    module.config ['localStorageServiceProvider', (localStorageServiceProvider)->
        localStorageServiceProvider.setPrefix('relevano')
    ]
    # http status 401 - user store data destroy
    module.config ['$httpProvider', ($httpProvider)->
        $httpProvider.interceptors.push(['$q', '$location', 'SessionService',
            ($q, $location, SessionService)->
                response: (response)->
                    if (response.status == 401)
                        SessionService.destroy()
                    return response || $q.when(response)
                responseError: (rejection)->
                    if (rejection.status == 401)
                        SessionService.destroy()
                    return $q.reject(rejection)
        ])
    ]
    # http status 401
    module.config ['$httpProvider', ($httpProvider)->
        $httpProvider.interceptors.push(['$q', '$location', 'NotificationService','SessionService',
            ($q, $location, NotificationService,SessionService)->
                response: (response)->
                    if (response.status == 401)
                        #console.log("Response 401")
                        SessionService.destroy()
                        NotificationService.warning("Authorization", response.data.message)
                        $location.path('/login')#.search('returnTo', $location.path())
                    return response || $q.when(response)
                responseError: (rejection)->
                    if (rejection.status == 401)
                        SessionService.destroy()
                        #console.log("Response Error 401", rejection)
                        if rejection.data?.message?
                            NotificationService.warning("Authorization", rejection.data.message)
                        $location.path('/login')#.search('returnTo', $location.path())
                    return $q.reject(rejection)
        ])
    ]
    ###* State control ###
    module.run [ '$rootScope',"$location","NotificationService","AuthService", ($rootScope,$location, NotificationService, AuthService)->
        if !AuthService.isAuthenticated()
            NotificationService.warning("Authorization", "Пожалуйства авторизуйтесь…")
            $location.path('/login')
            return
        else
            if $location.path()==''
                $location.path('/home')
    ]
    ###* ###
    module.run [ '$rootScope',"$location","NotificationService","AuthService","SessionService", ($rootScope,$location, NotificationService, AuthService,SessionService)->
        $rootScope.$on '$stateChangeStart',  (event, toState, toParams, fromState, fromParams)->
            if toState.data?.accessForRoles? and AuthService.isAuthenticated()
                #console.log '$stateChangeStart',toState.data.accessForRoles,SessionService.hasRoles(toState.data.accessForRoles,true)
                if AuthService.isAuthenticated() and !SessionService.hasRoles(toState.data.accessForRoles,true)# or AuthService.isAuthorized(toState.data.accessForRoles)!=true)
                    NotificationService.warning("Authorization", "Access Denied! You should be assigned #{toState.data.accessForRoles} role!")
                    event.preventDefault();
            if !AuthService.isAuthenticated() and toState.name !='security' and toState.name !='home'
                NotificationService.warning("Authorization", "Пожалуйства авторизуйтесь…")
                event.preventDefault();
                $location.path('/login')
                return
            if AuthService.isAuthenticated() and toState.name == 'security'
                event.preventDefault();



    ]
    #    ###* AUTH_EVENTS for  ###
    #    module.constant 'AUTH_EVENTS',
    #        loginSuccess: 'auth-login-success'
    #        loginFailed: 'auth-login-failed'
    #        logoutSuccess: 'auth-logout-success'
    #        sessionTimeout: 'auth-session-timeout'
    #        notAuthenticated: 'auth-not-authenticated'
    #        notAuthorized: 'auth-not-authorized'
    #    ###* USER_ROLES ###
    #    module.constant 'USER_ROLES',
    #        all: '*'
    #        admin: 'admin'
    #        datamanager: 'datamanager'
    #        dataseacher: 'dataseacher'
    #    ###
    #    #TODO: add in templates
    #    ###
    #    module.directive 'relevanoLoginToolbar', ['AUTH_EVENTS', (AUTH_EVENTS)->
    #        return {
    #        restrict: 'A'
    #        template: tplIndex #'<div ng-if="visible" data-ng-include="'login-form.html'">'
    #        link: (scope)->
    #            showDialog = ->
    #                scope.visible = true
    #            scope.visible = false
    #            scope.$on(AUTH_EVENTS.notAuthenticated, showDialog)
    #            scope.$on(AUTH_EVENTS.sessionTimeout, showDialog)
    #        }
    #    ]