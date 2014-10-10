###
Module dependencies
###
define [
    'angular'
    'cs!./namespace'
], (
    angular
    namespace
)->
    ## create instance angularjs module
    return angular.module( namespace, [
    ]).directive('draggable',[->

        return {
           restrict: 'A'
           link: (scope,element)->
                el = element[0]
                el.draggable = false;
        }
    ])