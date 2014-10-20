define ['cs!./../config','cs!./directives'],(config,module)->

    return module.directive 'draggableBlockinfo', [ ->

        return {
            restrict: 'A'
            scope:
                value: '=value'
            link:(scope,element)->
                        ## DragStart
                _handleDragStart = (e)->
                    @.style.opacity = '0.4'
                    e.dataTransfer.effectAllowed = 'copy'
                    console.log 'scope data = ',scope.value
                    _data =  scope.value# {id:1,name:"test"}
                    e.dataTransfer.setData 'json/blockinfo', angular.toJson _data
                    @.classList.add('over');
                    return false
                _handleDragEnd = (e)->
                    @.style.opacity = '1'
                    @.classList.remove('over');
                    return false

                el = element[0]
                el.draggable = true
                el.addEventListener 'dragstart', _handleDragStart, false
                el.addEventListener 'dragend', _handleDragEnd, false

        }

    ]