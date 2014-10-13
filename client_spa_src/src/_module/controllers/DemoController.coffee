define ['cs!./../config','cs!./controllers'],(config,module)->

    return module.controller  'DemoController', [
        '$scope'
        ($scope)->

            ## demo event
            $scope.onClick = (event = null)->
                event.preventDefault if !!event
                return

    ]