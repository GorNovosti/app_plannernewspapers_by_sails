###
Module configuration
###
define [
    'cs!./namespace'
    'cs!./module'
    'cs!./statespace' ## Configuration for ui-route state
], (namespace, module, statespace)->
    module.config ['$stateProvider', ($stateProvider)->
        ###
        Main configuration $stateProvider
        ###
        $stateProvider.state statespace.name,
            url: statespace.url
            views:
                "main@": ##TODO: do control name ui-view for display template content
                    templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/defaultscreen.tpl.html" ##NOTE: name "defaultscreen.tpl.html" must be change
                    controller: ['$scope', ($scope)->##NOTE: simple default controller.
                        $scope.statespace = statespace
                    ]
            data:
                pageTitle: statespace.pageTitle  ## Name for set title of page
    ]
