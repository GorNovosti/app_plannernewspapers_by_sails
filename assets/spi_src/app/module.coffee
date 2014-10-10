###
Module dependencies
###
define ['angular'
    'cs!./namespace'
    'cs!./states'
    'angular-ui-router'
    'angular-ui-router.stateHalper'
], (angular
    namespace
    states
)->
    ## create instance angularjs module
    module = angular.module(namespace, ['ui.router','ui.router.stateHelper'])
    module.config [ 'stateHelperProvider',(stateHelperProvider)->

        stateHelperProvider.setNestedState(states)
        #        statespace.name,
        #            url: statespace.url
        #            views:
        #                "main@": ##TODO: do control name ui-view for display template content
        #                    templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/defaultscreen.tpl.html" ##NOTE: name "defaultscreen.tpl.html" must be change
        #                    controller: ['$scope', ($scope)->##NOTE: simple default controller.
        #                        $scope.statespace = statespace
        #                    ]
        #            data:
        #                pageTitle: statespace.pageTitle  ## Name for set title of page
    ]
    module.run [->
        console.log 'run for module', namespace
        states.resolve = []
        #console.warn 'states', states
    ]

    return module