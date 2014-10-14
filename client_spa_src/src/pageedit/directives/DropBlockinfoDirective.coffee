define ['cs!./../config','cs!./directives'],(config,module)->

    return module.directive 'dropBlockinfo', [ ->

        ## DargEnter
        _handleDragEnter = (e)->
            ## this / e.target is the current hover target.
            @.classList.add 'over'
            return false
        ## DragOver
        _handleDragOver = (e)->
            e.dataTransfer.dropEffect = 'copy'
            e.preventDefault() if !!e.preventDefault
            return false
        ## DragLeave
        _handleDragLeave = (e)->
            @.classList.remove 'over'
            return false

        return {
            restrict: 'A'
            scope:
                drop: '&'#parent
            link:(scope,element)->
                el = element[0]
                el.draggable = true
                _handleDropBlockinfo = (e)->
                    e.stopPropagation() if !!e.stopPropagation
                    _data =  e.dataTransfer.getData('json/blockinfo')
                    console.log  'json/blockinfo',  _data
                    @.classList.remove('over');
                    # call the drop passed drop function
                    scope.$apply('drop('+_data+')');
                    return false

                el.addEventListener 'dragenter', _handleDragEnter, false
                el.addEventListener 'dragover' , _handleDragOver, false
                el.addEventListener 'dragleave', _handleDragLeave, false
                el.addEventListener 'drop', _handleDropBlockinfo, false

                element.on '$destroy', ->
                    console.log 'is destroy'
                    el.addEventListener 'dragenter', _handleDragEnter
                    el.addEventListener 'dragover' , _handleDragOver
                    el.addEventListener 'dragleave', _handleDragLeave
                    el.addEventListener 'drop', _handleDropBlockinfo 
        }

    ]