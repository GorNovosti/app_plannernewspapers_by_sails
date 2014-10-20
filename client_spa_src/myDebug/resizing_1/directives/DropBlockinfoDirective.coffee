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
                dopParam: '='
            controller: [ '$scope',($scope)->

                $scope.onDrop = (data)->
                    console.log 'controller on drop data=',data
                    $scope.$apply ->
                        $scope.drop()(data)
                    return

            ]
            link:(scope,element,attr)->
                el = element[0]
                el.draggable = false

                _handleDropBlockinfo = (e)->
                    e.stopPropagation() if !!e.stopPropagation
                    _data =  e.dataTransfer.getData('json/blockinfo')
                    console.log  'json/blockinfo',  _data
                    @.classList.remove('over');
                    # call the drop passed drop function
                    #scope.$apply('drop('+ {blockinfo:angular.toJson _data}+')');
                    scope.onDrop(JSON.parse _data)
##                    scope.$apply ->
##                        console.log 'isss', angular.toJson _data
##                        scope.drop({'test':2})
                    return false

                el.addEventListener 'dragenter', _handleDragEnter, false
                el.addEventListener 'dragover' , _handleDragOver, false
                el.addEventListener 'dragleave', _handleDragLeave, false
                el.addEventListener 'drop', _handleDropBlockinfo, false

#                element.on '$destroy', ->
#                    console.log 'is destroy'
#                    el.addEventListener 'dragenter', _handleDragEnter
#                    el.addEventListener 'dragover' , _handleDragOver
#                    el.addEventListener 'dragleave', _handleDragLeave
#                    el.addEventListener 'drop', _handleDropBlockinfo
        }

    ]