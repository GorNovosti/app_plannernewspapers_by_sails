###
Выполнение событий мыши при привязки обработчиков конкретного элемента
Implemented aprouch from http://www.codeproject.com/Articles/709340/Implementing-a-Flowchart-with-SVG-and-AngularJS#Dragging_Service
###
define ['cs!./directives'],(module)->
    _name = 'mouseCapture'
    module.factory "#{module.name.replace /\.+/g, "_"}Factory",["$rootScope", ($rootScope)->
        ## Element that the mouse capture applies to, defaults to 'document'  unless the 'mouse-capture' directive is used.
        $element = document
        ## Set when mouse capture is acquired to an object that contains handlers for 'mousemove' and 'mouseup' events.
        mouseCaptureConfig = null
        ## Handler for mousemove events while the mouse is 'captured'.
        _mouseMove = (evt)->
            #console.log 'mouseUp'
            if mouseCaptureConfig?.mouseMove?
                mouseCaptureConfig.mouseMove(evt)
                $rootScope.$digest()
            return
        ## Handler for mouseup event while the mouse is 'captured'.
        _mouseUp = (evt)->
            #console.log 'mouseUp'
            if mouseCaptureConfig?.mouseUp?
                mouseCaptureConfig.mouseUp(evt)
                $rootScope.$digest()
            return
        return {
            ## Register an element to use as the mouse capture element instead of the default which is the document.
            ## Регистрация в качестве элемента захвата событий мыши
            registerElement: (elm)->
                $element = elm
                return
            ## Acquire the 'mouse capture'. After acquiring the mouse capture mousemove and mouseup events will be forwarded to callbacks in 'config'.
            ## Привязка событий "захват мыши". После привязки к элементу событий mousemove и mouseup выполняется вызов вункций обратного вызова
            acquire: (evt,config)->
                ## Release any prior mouse capture.
                ## Испольнить все основные события связыанный с событием
                @.release()
                mouseCaptureConfig = config
                ##fix no jQuery
                #$element.mousemove(_mouseMove)
                #$element.mouseup(_mouseUp)
                $element.bind 'mousemove',_mouseMove
                $element.bind 'mouseup', _mouseUp
                return
            release: ->

                if mouseCaptureConfig?
                    #console.log mouseCaptureConfig
                    if mouseCaptureConfig?.released?
                        #Let the client know that their 'mouse capture' has been released.
                        mouseCaptureConfig.released()
                    mouseCaptureConfig = null
                #console.warn mouseCaptureConfig, $element
                $element.unbind "mousemove", _mouseMove
                $element.unbind "mouseup", _mouseUp
                return
        }
    ]

    module.controller "#{module.name.replace /\.+/g, "_"}Controller", [
        "$scope"
        "$element"
        "$attrs"
        "#{module.name.replace /\.+/g, "_"}Factory"
        ($scope, $element,$attrs,mouseCapture)->
            mouseCapture.registerElement($element);
            constructor: ->
                console.log "init #{module.name.replace /\.+/g, "_"}Controller"
    ]
    module.directive  _name ,[ ->
        return {
            restrict: "A"
            controller: "#{module.name.replace /\.+/g, "_"}Controller"
            link: (scope)->
                console.log "#{module.name.replace /\.+/g, "_"}Controller"+'mouseCapture init'

        }
    ]
    ###
    ========================
    Help for draggin
    ========================
    ###
    module.factory "dragging",['$rootScope',"#{module.name.replace /\.+/g, "_"}Factory", ($rootScope, mouseCapture) ->
        #
        # Threshold for dragging.
        # When the mouse moves by at least this amount dragging starts.
        #
        threshold = 1

        #
        # Called by users of the service to register a mousedown event and start dragging.
        # Acquires the 'mouse capture' until the mouseup event.
        #
        startDrag: (evt, config)->
            dragging = false
            x = evt.pageX
            y = evt.pageY

            #
            # Handler for mousemove events while the mouse is 'captured'.
            #
            mouseMove = (evt) ->
                #console.log dragging
                unless dragging
                    if evt.pageX - x > threshold or evt.pageY - y > threshold
                        dragging = true
                        config.dragStarted x, y, evt  if config.dragStarted

                        # First 'dragging' call to take into account that we have
                        # already moved the mouse by a 'threshold' amount.
                        config.dragging evt.pageX, evt.pageY, evt  if config.dragging
                else
                    config.dragging evt.pageX, evt.pageY, evt  if config.dragging
                    x = evt.pageX
                    y = evt.pageY
                return


            #
            # Handler for when mouse capture is released.
            #
            released = ->
                if dragging
                    config.dragEnded()  if config.dragEnded
                else
                    config.clicked()  if config.clicked
                return


            #
            # Handler for mouseup event while the mouse is 'captured'.
            # Mouseup releases the mouse capture.
            #
            mouseUp = (evt) ->
                mouseCapture.release()
                evt.stopPropagation()
                evt.preventDefault()
                return


            #
            # Acquire the mouse capture and start handling mouse events.
            #
            mouseCapture.acquire evt,
                mouseMove: mouseMove
                mouseUp: mouseUp
                released: released

            evt.stopPropagation()
            evt.preventDefault()
            return
        ]