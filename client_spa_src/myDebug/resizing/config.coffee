define [],()->
    _namespace = 'resizing'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/resizing.tpl.html"
            controller:["$scope",($scope)->
                $scope.listBlockinfoTpl = [ 
                    id:2
                    name: "Шаблон Блок 'вставка'"
                    type: 'comment'
                    x:30
                    y:30
                    width: 30
                    height: 30
                ]
            ]
        ]
    }