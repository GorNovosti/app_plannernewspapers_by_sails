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
                el.draggable = true;
                el.addEventListener 'dragstart',
                    (e)->
                        @.style.opacity = '0.4'
                        e.dataTransfer.effectAllowed = 'move'
                        console.log e.dataTransfer.effectAllowed = 'move'
                        @.classList.add('over');
                        false
                        , false

                el.addEventListener 'dragend',
                    (e)->
                        @.style.opacity = '0.9'
                        @.classList.add('over');
                        return false
                        , false
                return
        }
    ])