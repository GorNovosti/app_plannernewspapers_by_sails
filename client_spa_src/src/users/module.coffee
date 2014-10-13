###
 Template faile Mdule dependencies
 @exports "users"
 @author Nikolay Gerzhan <nikolay.gerzhan@gmail.com>
###
define [
    'angular'
    'cs!./namespace'
    'ng-table'
], (angular
    namespace
)->
    ## create instance angularjs module
    return angular.module namespace, ['ngTable']