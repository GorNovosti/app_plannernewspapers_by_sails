define [],()->
    _namespace = 'pageedit'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace+'/:id'
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/pageedit_index.tpl.html"
            resolve:
                BlockinfoService: ['BlockinfoService',(BlockinfoService)->
                    return BlockinfoService
                ]
                editNewspaper: [ 'ReleasesService','$stateParams','baseUrl',(ReleasesService,$stateParams,baseUrl)->
                    if $stateParams.id?
                        return  (new  ReleasesService()).$get({id:$stateParams.id})
                    else
                        return false
                ]
                APIService:[ "BlockinfoService",(BlockinfoService)->
                        return BlockinfoService
                ]
            controller:['$scope','$modal','BlockinfoService','editNewspaper', 'APIService','DialogService',($scope,$modal,BlockinfoService,editNewspaper,APIService,DialogService)->
                $scope.currEditPage = 1
                $scope.totalItems = 20
                $scope.pagesCountList = ->
                    if  $scope.editPage?.pagesCount?
                        return [1..$scope.editPage?.pagesCount]
                    else
                        return [1..10]
                $scope.listBlockinfoTpl = []

                $scope.editNewspaper = editNewspaper
                $scope.totalItems = editNewspaper.pagesCount
                #console.log $scope.totalItems ,editNewspaper.pagesCount
                ###
                Load list of templates blockinfo
                ###
                _reloadList = ->
                    #$scope.totalItems = editNewspaper.pagesCount
                    BlockinfoService.query(
                        (data)->
                            $scope.listBlockinfoTpl.length =0
                            angular.forEach data , (item)->
                                item.x = if item.x? then  item.x else 0
                                item.y = if item.y? then  item.y else 0
                                $scope.listBlockinfoTpl.push item
                            console.log 'data',data
                    )
                _reloadList()
                ###

                ###
                $scope.handleDropBlockInfo = (data=null,page)->
                    console.log data,page
                    data.$createdAt = (new Date()).toISOString()
                    data.page = page
                    $scope.editNewspaper.blockInfo.push  data#{name:"test"}
                    return
                ###
                add new Blockinfo
                ###
                $scope.onAddBlockinfo = $scope.onEditBlockinfo =  $scope.onEditTplBlockinfo = (item = null)->
                    tplForm = 'blockinfo'
                    $modal.open(
                        windowClass: 'addModal'
                        templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/form.#{tplForm}.tpl.html"
                        resolve:
                            entity: ->
                                return item #new APIService.get(item)
                            isNew: ->
                                if item?
                                    return false
                                else
                                    return true

                        controller: [
                            "$scope"
                            "$modalInstance"
                            "entity"
                            "isNew"
                            "NotificationService"
                            ($scope, $modalInstance, entity,isNew,NotificationService)->
                                $scope.isNew = isNew
                                $scope.isBusy = false

                                if isNew
                                    $scope.currEntity = null
                                    console.log APIService
                                    $scope.editEntity = new APIService()
                                else
                                    $scope.currEntity =  entity #_.clone entity
                                    $scope.editEntity =  new APIService(entity)# _.clone entity #entity
                                    $scope.editEntity.canEdit = true

                                ###* on save in server-side ###
                                $scope.onSave = ->
                                    $scope.isBusy = true
                                    if isNew
                                        $scope.editEntity.$save().then(
                                            (result)->
                                                console.log result
                                                $scope.isBusy = false
                                                #$scope.tableParams.reload()
                                                $modalInstance.close(entity)
                                            (error)->
                                                $scope.isBusy = false
                                        )
                                    else
                                        console.log '====',$scope.editEntity
                                        $scope.editEntity.$update().then(
                                            (result)->
                                                $scope.isBusy = false
                                                console.log result
                                                entity = result
                                                $modalInstance.close(entity)
                                            (error)->
                                                $scope.isBusy = false
                                        )
                                    #$scope.tableData.push($scope.newItem)
                                    #$scope.tableParams.reload()
                                    #$modalInstance.close(entity)
                                    #else
                                    #    TasksDataService.notifyService.info 'Duplicate', "Attribute #{$scope.newItem.attributeName} already exist"
                                $scope.onCancel = ->
                                    $modalInstance.dismiss('cancel')
                        ]
                        scope: $scope
                    ).result.then(
                        (result)->
                            ##TODO: Socket update
                            if item?
                                _.extend item , result
                            else
                                _reloadList()

                        (result)->
                            console.log result
                    )

                ###* confirm delete (used service) ###
                $scope.onDeleteTplBlockinfo = (item)->
                   delDlg = DialogService.deleteDialog "Удаление","Вы действительно желаете удалить шаблон с именем <strong>#{item.name}</strong>?"
                   delDlg.result.then(
                       ##confirn delete entity
                       (res)->
                           $scope.isBusy = true
                           item.$delete().then(
                               (result)->
                                   $scope.isBusy = false
                                   #$scope.tableParams.reload()
                                   #$modalInstance.close(null)
                               (error)->
                                   $scope.isBusy = false
                           )
                   )
            ]


        ]
    }