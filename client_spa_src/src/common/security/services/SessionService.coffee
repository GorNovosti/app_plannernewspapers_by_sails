###
SessionService
#NOTE: keep the user`s sessions information
###
define ['cs!./../module'], (module)->
    module.factory 'SessionService', ['$log', '$window','localStorageService',($log,$window,localStorageService)->
        new class SessionService
            @currentUser: null
            ###* construct class and get user data ###
            constructor: ()->
                @currentUser = localStorageService.get('user',{name:"test"})
                return

            save: (data)=>
                localStorageService.set('user',data)
                @currentUser = data
                return
            ###* destroy user data  ###
            destroy: ()=>
                localStorageService.remove('user')

                @currentUser = null
                return
            ###* clear all store data  ###
            clear: ()=>
                localStorageService.clearAll()
                @currentUser = null
                return

            getUserId: =>
                #currentUser.userId
                if @currentUser?.userId?
                    return @currentUser.userId
                else
                    return null


            ###* check role(s) in current user roles. the scope is set in HeaderController ###
            hasRoles: (roles, anyRole = false)=>
                if !!!@currentUser
                    return false
                ###* processing of default case - if any of roles exists in user roles ###
                if anyRole is true
                    ->
                    ###* check if we have any intersection of current user roles and requested roles ###
                    return Boolean((_.intersection(@currentUser.roles, roles)).length)
                else
                    ->
                    ###* check if requested roles list is subset of currentUser.roles list ###
                    #return (_.intersection(@currentUser.roles, roles)).length == roles.length
                    ###* check if requested roles list is subset of currentUser.role ###
                    return ((_.indexOf(roles,@currentUser.role))  > -1)
            ###*  check current set user role###
            curRoles: (role, anyRole = false)=>
                if !!!@currentUser
                    return false
                else
                   console.log '@currentUser',role, @currentUser[role]
                   @currentUser[role]



    ]