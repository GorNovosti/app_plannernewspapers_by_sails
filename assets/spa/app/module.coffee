###
Module dependencies
###
define ['angular'
    'cs!./namespace'
], (angular
    namespace
)->
    ## create instance angularjs module
    console.log 'namespace'

    module = angular.module(namespace, [])
    module.run([->
        console.log 'module', namespace
        ])
    console.warn module
    return module.name