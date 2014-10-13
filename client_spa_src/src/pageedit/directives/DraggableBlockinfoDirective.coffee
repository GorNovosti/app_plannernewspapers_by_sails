define ['cs!./../config','cs!./directives'],(config,module)->

    return module.directive 'draggableBlockinfo', [ ->

        return {
            restrict: 'A'
            link:(scope,element)->
                        ## DragStart
                _handleDragStart = (e)->
                    @.style.opacity = '0.4'
                    e.dataTransfer.effectAllowed = 'copy'
                    e.dataTransfer.setData 'json/blockinfo', {id:1,name:"test"}
                    @.classList.add('over');
                    return false

                el = element[0]
                el.draggable = true
                el.addEventListener 'dragstart', _handleDragStart, false
        }

    ]