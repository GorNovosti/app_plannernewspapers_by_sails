###
LoginController

###
define [
    'cs!./../module'
    'cs!./../services/AuthService'
],(
    module
)->
    module.controller 'LoginController', ['$scope','$log','$state','$location','AuthService', 'SessionService',($scope,$log,$state,$location,AuthService,SessionService)->
        class LoginController
            constructor: ->

              return

            $scope.currentUser = SessionService.currentUser

            $scope.isAuthenticated = AuthService.isAuthenticated
            ##TODO: delete user params
            $scope.credentials =
                email: 'demo@demo.com'
                password: 'demo123456'
                rememberMe: true
            ###
            call AuthService function. No control send data
            ###
            $scope.onSignIn = (data)->
                AuthService.signin(data).then(
                        (result)->
                            console.log result
                            $state.go "home"
                    )
                return
            ###  onSignOut  ###
            $scope.onSignOut = (url=null)->
                AuthService.signout().then(
                    ()->
                        if url?
                            $location.path url
                        else
                            $location.path '/login'
                )
                return
            ###* change current Role ###
            $scope.onSetCurrentRole = (_role)->
                AuthService.setUserRole(_role).then(
                    (data)->
                        $state.go '.',null,reload:true
                )
            ###* Control changes data in SessionService - current user information ###
            $scope.$watch(->
                  SessionService.currentUser
                , (currentUser) ->
                    $scope.currentUser = currentUser
                    return
                ,true )

    ]