define ['cs!./namespaces'],(namespaces)->
    _namespace = namespaces.name #'resizing'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/index.tpl.html"
            controller:["$scope",($scope)->
                $scope.namespaces = namespaces
                $scope.BlocksinfoTpl = [
                    id:1
                    name:"test1"
                    x:10
                    y:10
                ,
                    id:2
                    name:"test2"
                    x:50
                    y:50
                ]
            ]
        ]
    }