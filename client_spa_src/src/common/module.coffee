###
* @name common
###
define [
    'cs!./namespace'
    'angular'
    'cs!./dialogService/index'
    'angularjs-toaster'
], (namespace, angular, module1) ->
    app = angular.module(namespace, [
        'toaster'
        module1
    ])
 
    app