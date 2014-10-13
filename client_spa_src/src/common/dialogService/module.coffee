###
Module "services"
###
define [
    'angular'
    'cs!./namespace'
    'angular-dialog-service'
], (angular
    namespace)->
    return angular.module namespace, [
        'dialogs.main'
        'dialogs.default-translations'
    ]