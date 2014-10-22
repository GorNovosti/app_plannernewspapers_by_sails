###*
* @descripion Директива просмотра содержания страницы(полосы) газеты

###
define [
    'cs!./directives'
],(
    module

)->
    module.controller 'ViewerPageNewspaperController',['$scope', 'dragging', '$element', ($scope, dragging, $element)->
        controller = @

        ## Reference to the document and jQuery, can be overridden for testting.
	#@.document4 = document4
	# Wrap jQuery so it can easily be  mocked for testing.
	#@.jQuery = (element)->
	#	return $(element)

        ## Init data-model variables.
        $scope.dragSelecting = false;
        ## Reference to the node that the mouse is currently over
        $scope.mouseOverNode = null;
        # The class for
        nodeClass = 'node'

        # Translate the coordinates so they are relative to the svg element
        @.translateCoordinates = (x, y)->
            svg_elem =  $element[0]
            matrix = svg_elem.getScreenCTM()
            point = svg_elem.createSVGPoint()
            point.x = x
            point.y = y
            return point.matrixTransform(matrix.inverse())

        #        $scope.onEditNode = (evt,node)->
        #            console.log 'onEditNode',evt,node
        #            $scope.$apply ->
        #                        $scope.onDblClick()(evt,node)
        #            #evt.preventDefault() if !!evt
        ##Called on mouse down in the chart
        $scope.mouseDown = (evt)->
            console.log 'mouseDown',evt
            ## Deselect all
            ## $scope.chart.deselectAll();
            dragging.startDrag evt,
                ## Commence dragging... setup variables to display the drag selection rect
                dragStarted:  (x, y)->
                    $scope.dragSelecting = true;
                    startPoint = controller.translateCoordinates(x, y);
                    console.log 'startPoint',startPoint
                    $scope.dragSelectionStartPoint = startPoint;
                    $scope.dragSelectionRect =
                        x: startPoint.x
                        y: startPoint.y
                        width: 0
                        height: 0

                ## Update the drag selection rect while dragging continues.
                dragging: (x, y)->
                    startPoint = $scope.dragSelectionStartPoint;
                    curPoint = controller.translateCoordinates(x, y);
                    console.log 'draggin node mouse down', curPoint
                    $scope.dragSelectionRect =
                        x: if curPoint.x > startPoint.x then startPoint.x else curPoint.x,
                        y: if curPoint.y > startPoint.y then startPoint.y else curPoint.y,
                        width: if curPoint.x > startPoint.x then  curPoint.x - startPoint.x else startPoint.x - curPoint.x,
                        height: if curPoint.y > startPoint.y then curPoint.y - startPoint.y else startPoint.y - curPoint.y,
                ## Dragging has ended... select all that are within the drag selection rect.
                dragEnded: ->
                    $scope.dragSelecting = false
                    console.log 'need release $scope.chart.applySelectionRect($scope.dragSelectionRect);', $scope.dragSelectionRect
                    delete $scope.dragSelectionStartPoint;
                    delete $scope.dragSelectionRect;
                    return
                    #				$scope.dragSelecting = false;
                    #				$scope.chart.applySelectionRect($scope.dragSelectionRect);
                    #				delete $scope.dragSelectionStartPoint;
                    #				delete $scope.dragSelectionRect;
                    #
        #
        # Handle mousedown on a blockinfo.
        #
        $scope.blockinfoMouseDown = (evt, node)->
            console.warn 'fix chart = $scope.chart'
            #chart = $scope.chart
            lastMouseCoords = undefined
            dragging.startDrag evt,
                # Node dragging has commenced.
                dragStarted: (x, y) ->
                    lastMouseCoords = controller.translateCoordinates(x, y)

                    #
                    # If nothing is selected when dragging starts, at least select the node we are dragging.

                    #                    unless node.selected()
                    #                        console.warn 'fix chart.deselectAll()'
                    #                        #chart.deselectAll()
                    #
                    #                        node.select()
                    #node.$isSelect = true

                    return


                #
                # Dragging selected nodes... update their x,y coordinates.
                #
                dragging: (x, y) ->
                    #console.info x,y
                    curCoords = controller.translateCoordinates(x, y)
                    ## grid points
                    step = $scope.step || 10 ## step for grid
                    curCoords.x = Math.round(curCoords.x/step)*step
                    curCoords.y = Math.round(curCoords.y/step)*step

                    lastMouseCoords.x = Math.round(lastMouseCoords.x/step)*step
                    lastMouseCoords.y = Math.round(lastMouseCoords.y/step)*step
                    ## -- grid points
                    deltaX = curCoords.x - lastMouseCoords.x
                    deltaY = curCoords.y - lastMouseCoords.y
                    console.warn 'fix  chart.updateSelectedNodesLocation deltaX, deltaY'
                    #chart.updateSelectedNodesLocation deltaX, deltaY
                    node.x += deltaX
                    node.y += deltaY
                    lastMouseCoords = curCoords
                    return


                #
                # The node wasn't dragged... it was clicked.
                #
                clicked: (evt,node)->
                    console.warn 'fix chart.handleNodeClicked node, evt.ctrlKey',evt,node
                    #                    #chart.handleNodeClicked node, evt.ctrlKey
                    #                    #node.$isSelect = true
                    #                    console.log evt,node
                    #                    #            startPoint = controller.translateCoordinates(x, y);
                    #                    #            $scope.dragSelectionStartPoint = startPoint;
                    #                    $scope.dragResizingRect =
                    #                        x: node.x
                    #                        y: node.y
                    #                        width: node.width|| 30
                    #                        height: node.height || 30
                    #                        node: node
                    #                    $scope.dragResizing = true
                    return

                dragEnded: ->
                    step =$scope.step || 10 ## step for grid
                    node.x = Math.floor(node.x/step)*step
                    node.y = Math.floor(node.y/step)*step
                    return
            return
        #
        # Handle mousedown on a blockinfo.
        #
        $scope.blockResizeMouseDown = (evt, node)->
            console.warn 'fix chart = $scope.chart'
            #chart = $scope.chart
            lastMouseCoords = undefined
            dragging.startDrag evt,
                # Node dragging has commenced.
                dragStarted: (x, y) ->
                    lastMouseCoords = controller.translateCoordinates(x, y)
                    #
                    # If nothing is selected when dragging starts, at least select the node we are dragging.

                    #                    unless node.selected()
                    #                        console.warn 'fix chart.deselectAll()'
                    #                        #chart.deselectAll()
                    #
                    #                        node.select()
                    #node.$isSelect = true

                    return
                #
                # Dragging selected nodes... update their x,y coordinates.
                #
                dragging: (x, y) ->
                    #console.info x,y
                    curCoords = controller.translateCoordinates(x, y)
                    ## grid points
                    step = $scope.step || 10 ## step for grid
                    curCoords.x = Math.round(curCoords.x/step)*step
                    curCoords.y = Math.round(curCoords.y/step)*step

                    lastMouseCoords.x = Math.round(lastMouseCoords.x/step)*step
                    lastMouseCoords.y = Math.round(lastMouseCoords.y/step)*step
                    ## -- grid points
                    deltaX = curCoords.x - lastMouseCoords.x
                    deltaY = curCoords.y - lastMouseCoords.y

                    #TODO: console.warn 'fix  chart.updateSelectedNodesLocation deltaX, deltaY',deltaX,deltaY
                    #chart.updateSelectedNodesLocation deltaX, deltaY

                    # Don't allow a too small size.
                    node.width += deltaX
                    node.height += deltaY

                    node.width = 10 if node.width<10
                    node.height = 10 if node.height<10
                    lastMouseCoords = curCoords
                    return


                #
                # The node wasn't dragged... it was clicked.
                #
                clicked: (evt)->
                    console.warn 'fix chart.handleNodeClicked node, evt.ctrlKey',evt,node
                    #chart.handleNodeClicked node, evt.ctrlKey
                    node.$isSelect = true
                    console.log evt,node
                    #            startPoint = controller.translateCoordinates(x, y);
                    #            $scope.dragSelectionStartPoint = startPoint;
                    $scope.dragResizingRect =
                        x: node.x
                        y: node.y
                        width: node.width|| 30
                        height: node.height || 30
                    $scope.dragResizing = true
                    return

                dragEnded: ->
                    step =$scope.step || 10 ## step for grid
                    node.x = Math.floor(node.x/step)*step
                    node.y = Math.floor(node.y/step)*step
                    return
            return
 
        ]


    module.directive 'viewerPageNewspaper', [ ->
        return {
            #require: '^ngModel'
            restrict: 'A'
            replace: false
            scope:  false
                #model: "=ngModel"
                #onDblClick: '=onDblClickBlockinfo'
            #templateUrl:  "templates/#{module.name.replace /\.+/g, "/"}/viewer_page_newspaper.tpl.html"
            controller: 'ViewerPageNewspaperController'
            link:(scope,element,attrs)->
                console.log element[0]
        }


    ]