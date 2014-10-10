###
Module dependencies
###
define ['angular'
        'cs!./namespace'
        'cs!common/index' ## Use common module
], (angular
    namespace
    commonModule)->
    ## create instance angularjs module
    return angular.module namespace, [
        commonModule
    ]