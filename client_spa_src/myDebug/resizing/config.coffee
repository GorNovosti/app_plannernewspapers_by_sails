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
                    #                    id:1
                    #                    name: "Шаблон Блок 'статья'"
                    #                    type: 'acticle'
                    #                    x:10
                    #                    y:10
                    #                    width:210
                    #                    height: 400
                    #                ,
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