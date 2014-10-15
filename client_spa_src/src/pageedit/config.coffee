define [],()->
    _namespace = 'pageedit'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/pageedit_index.tpl.html"
            controller:['$scope',($scope)->
                $scope.editPage =
                    infoblocks:[]
                $scope.listBlockinfoTpl = [
                    id:1
                    name: "Шаблон Блок 'статья'"
                    type: 'acticle'
                    x:10
                    y:10
                ,
                    id:2
                    name: "Шаблон Блок 'вставка'"
                    type: 'comment'
                    x:30
                    y:30
                ]
                $scope.handleDrop = (data=null)->
                    $scope.editPage.infoblocks.push  data#{name:"test"}
                    console.log data
                    return
            ]
        ]
    }