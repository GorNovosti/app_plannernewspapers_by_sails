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
        # Handle mousedown on a node.
        #
        $scope.nodeMouseDown = (evt, node) ->
            console.warn 'fix chart = $scope.chart'
            #chart = $scope.chart
            lastMouseCoords = undefined
            console.log evt,node
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

                    return


                #
                # Dragging selected nodes... update their x,y coordinates.
                #
                dragging: (x, y) ->
                    console.info x,y
                    curCoords = controller.translateCoordinates(x, y)
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
                clicked: ->
                    console.log 'fix chart.handleNodeClicked node, evt.ctrlKey'
                    #chart.handleNodeClicked node, evt.ctrlKey
                    return
            return

        #$scope.$isSelect = null
        #                $scope.setSelect = (node)->
        #
        #                    $scope.$isSelect = node.id
        ]


    module.directive 'viewerPageNewspaper', [ ->
        return {
            require: '^ngModel'
            restrict: 'E'
            replace: true
            scope:
                model: "=ngModel"
            templateUrl:  "templates/#{module.name.replace /\.+/g, "/"}/viewer_page_newspaper.tpl.html"
            controller: 'ViewerPageNewspaperController'
        }


    ]