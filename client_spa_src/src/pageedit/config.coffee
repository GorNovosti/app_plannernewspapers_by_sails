define [],()->
    _namespace = 'pageedit'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/pageedit_index.tpl.html"
            resolve:
                BlockinfoService: ['BlockinfoService',(BlockinfoService)->
                    return BlockinfoService
                ]
            controller:['$scope','BlockinfoService',($scope,BlockinfoService)->

                $scope.pagesCountList = ->
                    if  $scope.editPage?.pagesCount?
                        return [1..$scope.editPage?.pagesCount]
                    else
                        return [1..1]
                $scope.editPage =
                    infoblocks:[]
                    createdAt: "2014-09-29T09:43:38.046Z"
                    id: "542929cac10378f41b85227f"
                    name: "testRelease2222"
                    pagesCount: 5
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
                BlockinfoService.query(
                    (data)->
                         angular.forEach data , (item)->
                            item.x = if item.x? then  item.x else 0
                            item.y = if item.y? then  item.y else 0
                            $scope.listBlockinfoTpl.push item
                         console.log 'data',data
                )
                $scope.handleDrop = (data=null,page)->
                    console.log data,page
                    data.$createdAt = (new Date()).toISOString()
                    data.page = page
                    $scope.editPage.infoblocks.push  data#{name:"test"}

                    return
            ]
        ]
    }