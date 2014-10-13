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
    ## DargEnter
    _handleDragEnter = (e)->
        ## this / e.target is the current hover target.
        @.classList.add 'over'
        return false
    ## DragOver
    _handleDragOver = (e)->
        e.dataTransfer.dropEffect = 'move'
        e.preventDefault() if !!e.preventDefault
        return false
    ## DragLeave
    _handleDragLeave = (e)->
        @.classList.remove 'over'
        return false
    ## create instance angularjs module
    return angular.module( namespace, [
    ]).directive('draggable',[->

        ## DragStart
        _handleDragStart = (e)->
            @.style.opacity = '0.4'
            e.dataTransfer.effectAllowed = 'move'
            dragSrcEl = @
            e.dataTransfer.setData('text','dragSrcEl.textContent')
            #            console.info e.dataTransfer.getData('text/html')
            @.classList.add('over');
            return false
        #        ## DargEnter
        #        _handleDragEnter = (e)->
        #            ## this / e.target is the current hover target.
        #            @.classList.add 'over'
        #            return false
        #        ## DragOver
        #        _handleDragOver = (e)->
        #            e.preventDefault() if !e.preventDefault
        #            e.dataTransfer.dropEffect = 'move'
        #            return false
        #        ## DragLeave
        #        _handleDragLeave = (e)->
        #            @.classList.remove 'over'
        #            return false
        ## DragEnd
        _handleDragEnd = (e)->
            console.log e,'dragend'
            @.style.opacity = '0.9'
            @.classList.remove 'over'
            return false
        ## Drop
        _handleDrop = (e)->
            console.info 'drop', e.dataTransfer.getData('text/html')
            console.info e.dataTransfer.getData('text/html')
            e.stopPropagation() if !!e.stopPropagation
            #            if dragSrcEl != @
            #                @.append  e.dataTransfer.getData('text/html')
            return false
        return {
            restrict: 'A'
            link: (scope,element)->
                el = element[0]
                el.draggable = true
                ##NOTE:
                el.addEventListener 'dragstart', _handleDragStart, false
                el.addEventListener 'dragenter', _handleDragEnter, false
                el.addEventListener 'dragover', _handleDragOver, false
                el.addEventListener 'dragleave', _handleDragLeave, false
                el.addEventListener 'dragend', _handleDragEnd, false
                el.addEventListener 'drop', _handleDrop, false

                return
        }
    ]).directive('cachingDropInfoblock',[ ->
        _handleDropBlockinfo = (e)->
            alert 'is drop'
            e.stopPropagation() if !!e.stopPropagation
            console.info e.dataTransfer.getData('text')

            return false
        return {
            rescrict: 'A'
            link:(scope,element,attrs)->
                console.log 'link caching drop blocinfo'
                el = element[0]
                #el.draggable = true
                # el.dropzone="copy string:text/html"
                el.addEventListener 'dragenter', _handleDragEnter, false
                el.addEventListener 'dragover' , _handleDragOver, false
                el.addEventListener 'dragleave', _handleDragLeave, false
                el.addEventListener 'drop', _handleDropBlockinfo, false
                return
        }

    ])