###
Module dependencies
###
define [
    'angular'
    'cs!./namespace'
    'angular-local-storage'
], (angular
    namespace)->
    ## create instance angularjs module
    return angular.module namespace, ['LocalStorageModule']