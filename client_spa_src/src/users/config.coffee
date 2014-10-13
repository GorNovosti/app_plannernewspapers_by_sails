###
Module configuration
###
define [
    'cs!./namespace'
    'cs!./module'
    'cs!./statespace' ## Configuration for ui-route state
    'cs!./services/ManageUsersService'
    'cs!./controllers/ManageUsersController'
], (namespace, module, statespace)->
    module.value 'baseUrl', 'http://localhost:1337/api/v1'
    module.config ['$stateProvider', ($stateProvider)->
        ###
        Main configuration $stateProvider
        ###
        console.warn statespace.url
        $stateProvider.state statespace.name,
            url: statespace.url
            ## views:
            ##   "main@": ##TODO: do control name ui-view for display template content
            templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/relevanousers.tpl.html"
            controller: 'ManageUsersController'
            resolve:
                APIService: ['ManageUsersService' , (_APIService)->
                    return _APIService

                ]
            data:
                pageTitle: statespace.pageTitle
                accessForRoles: ['admin', 'dataAnalyst']##4866
    ]
