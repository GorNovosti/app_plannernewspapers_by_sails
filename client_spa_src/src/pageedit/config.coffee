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
                ,
                    id:2
                    name: "Шаблон Блок 'вставка'"
                    type: 'comment'
                ]
                $scope.handleDrop = (data=null)->
                    $scope.editPage.infoblocks.push  {name:"test"}
                    console.log data
                    return 
            ]
        ]
    }