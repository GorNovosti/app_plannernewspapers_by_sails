###* AuthService ###
define ['cs!./../module', 'angular', 'cs!./SessionService'], (module, angular)->
    module.factory "AuthService", ["$log", "$http", "baseUrl", "SessionService","$rootScope",
        ($log, $http, baseUrl, SessionService,$rootScope)->
            new class AuthService
                constructor: ->
                    $rootScope.isAuthenticated = @.isAuthenticated
                    $rootScope.onSignOut = @.signout
                    return

                signin: (credentials)->
                    $http.post(baseUrl + '/auth/signin', credentials)
                    .then(
                        (result)->
                            SessionService.save result.data
                            return result.data
                    )

                signout: ()->
                    self = @
                    $http.post(baseUrl + '/auth/signout')
                    .then(
                        (result)->
                            SessionService.destroy()
                            return result.data
                        (result)->
                            SessionService.destroy()
                            return
                    )
                setUserRole: (_role)->
                    $http.put(baseUrl + '/auth/user/role', NewRole:_role)
                    .then(
                        (result)->
                            SessionService.save result.data
                            return result.data
                    )
                isAuthenticated: =>
                    return !!SessionService.currentUser
                ###
                control is access to resource
                ###
                isAuthorized: (authorizedRoles)=>
                    #console.log authorizedRoles,@isAuthenticated(),SessionService.currentUser.roles
                    authorizedRoles = [authorizedRoles]  unless angular.isArray(authorizedRoles)
                    #TODO: multi-roles?
                    #console.log SessionService.currentUser.role
                    @isAuthenticated() and authorizedRoles.indexOf(SessionService.currentUser.role) isnt -1
    ]