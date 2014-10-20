###
Директива изменения размера
###
define ['cs!./../../config','cs!./../directives'],(config,module)->
    ActionsEnum =
        None: 0
        LeftResize: 1
        TopResize: 2
        RightResize: 3
        BottomResize: 4
        TopLeftResize: 5
        BottomLeftResize: 6
        TopRightResize: 7
        BottomRightResize: 8
        Move: 9

    return module.directive 'svgResizing', [ ->
        _handleMouseDovnResizeAction = (e)->
            console.log e.target
            return
        return {

            restrict: 'A'
            scope: {}
            controller: [ '$scope',($scope)->
                controller = @
                $scope.currentAction = ActionsEnum.None

            ]
            link:(scope,element,attr)->
                el = element[0]
                console.log 'link SvgResizingDirective'
#                el.addEventListener 'mousemove',  (evt)->
#                    console.log '==', scope.currentAction
#                    , false
                _.forEach  ActionsEnum, (val,key)->
                    console.log key,val,
                    if !!(_el = element[0].getElementsByClassName(key))
                        #element[0].getElementsByClassName(key).addEventListener 'mousedown', _handleMouseDovnResizeAction , false
                        console.log '!!!',_el
                        angular.element(_el).bind "mousemove" , _handleMouseDovnResizeAction ,true
                return

        }

    ]