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
                BlockinfoTemplatesService:[ "BlockinfoTemplatesService",(BlockinfoTemplatesService)->
                    return BlockinfoTemplatesService
                ]
            controller:['$scope','$modal','BlockinfoService','editNewspaper', 'BlockinfoTemplatesService','DialogService',($scope,$modal,BlockinfoService,editNewspaper,BlockinfoTemplatesService,DialogService)->

                $scope.currEditPage = 1 ## Pagination configuration
                $scope.totalItems = 20  ## Pagination configuration
                $scope.step = 10 ## Configuration grid step
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
                    BlockinfoTemplatesService.query(
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
                add BlockInfo
                ###
                $scope.handleDropBlockInfo = (data=null,page)->
                    data.id = null
                    data.$createdAt = (new Date()).toISOString()
                    data.page = page
                    data.newspaper = $scope.editNewspaper.id
                    new BlockinfoService(data).$save(
                        (data)->
                            $scope.editNewspaper.blockInfo.push data
                    )
                    return
                ###
                add new Blockinfo
                ###
                $scope.onAddBlockinfoTemplates =  $scope.onEditTplBlockinfo = (item = null)->
                    tplForm = 'blockinfotemplates'
                    $modal.open(
                        windowClass: 'addModal'
                        templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/form.#{tplForm}.tpl.html"
                        resolve:
                            entity: ->
                                return item #new BlockinfoTemplatesService.get(item)
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
                                    $scope.editEntity = new BlockinfoTemplatesService()
                                else
                                    $scope.currEntity =  entity #_.clone entity
                                    $scope.editEntity =  new BlockinfoTemplatesService(entity)# _.clone entity #entity
                                    #$scope.editEntity.$canEdit = true

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


                ###*
                add and create new Blockinfo
                ###
                $scope.onAddBlockinfo = $scope.onEditBlockinfo  = (item = null)->
                    tplForm = 'blockinfo'
                    $modal.open(
                        windowClass: 'addModal'
                        templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/form.#{tplForm}.tpl.html"
                        resolve:
                            entity: ->
                                return item #new BlockinfoTemplatesService.get(item)
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
                                    $scope.editEntity = new BlockinfoService()
                                else
                                    $scope.currEntity =  entity #_.clone entity
                                    $scope.editEntity =  new BlockinfoService(entity)# _.clone entity #entity
                                    #$scope.editEntity.$canEdit = true

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

                ###*
                    confirm delete (used service)
                ###
                $scope.onDeleteTplBlockinfo = (item)->
                    delDlg = DialogService.deleteDialog "Удаление","Вы действительно желаете удалить шаблон с именем <strong>#{item.name}</strong>?"
                    delDlg.result.then(
                        ##confirn delete entity
                        (res)->
                            $scope.isBusy = true
                            item.$delete().then(
                                (result)->
                                    $scope.isBusy = false
                                    #_reloadList()
                            ).finally(
                                ->
                                    $scope.isBusy = false
                                    _reloadList()
                            )
                    )
                ###* confirm delete (used service) ###
                $scope.onDeleteBlockinfo = (e,item)->
                    delDlg = DialogService.deleteDialog "Удаление","Вы действительно желаете удалить блок с именем <strong>#{item.name}</strong>?"
                    delDlg.result.then(
                        ##confirn delete entity
                        (res)->
                            $scope.isBusy = true
                            new BlockinfoService(item).$delete().then(
                                (result)->
                                    ##TODO:
                                    $scope.editNewspaper.$get()

                            ).finally(
                                (data)->
                                    $scope.isBusy = false
                                    _reloadList()
                                )
                    )
                ###
                Function for filter
                filter BlockInfo for current page
                ###
                $scope.isCurrentPage = (_blockinfo = page:null)->
                    #console.log _blockinfo
                    return ($scope.currEditPage == _blockinfo.page)
                ###
                ###
                $scope.onSaveAsBlockinfoTemplate = (evt,node)->
                    #console.log node, angular.copy node
                    evt.preventDefault() if !!evt.preventDefault
                    item = {}
                    _.extend item ,node
                    delete item.id
                    delDlg = DialogService.deleteDialog "Сохранение в качестве шаблона","Вы действительно желаете сохранить блок с именем <strong>#{item.name}</strong> как шаблон?"

                    delDlg.result.then(
                        ##confirn delete entity
                        (res)->
                            $scope.isBusy = true
                            new BlockinfoTemplatesService(item).$save().then(
                                (result)->
                                    ##TODO:
                                    $scope.editNewspaper.$get()

                            ).finally(
                                (data)->
                                    $scope.isBusy = false
                                    _reloadList()
                                )
                    )
                ###
                ###
                $scope.onUpToBlockinfo = ($event, node, $last)->
                    console.log node.page,node.order,  $last
                    #if $index != 0
                    #node.order =
                    console.log _max_level =_.max (_.filter $scope.editNewspaper.blockInfo, page:node.page), "order"
                    node.order = _max_level.order+1 if $last != true
                    node.$isChange = true if $last != true
                #'editNewspaper.blockInfo'
                ###
                $watch
                ###
                $scope.$watch(
                    -> _.filter $scope.editNewspaper.blockInfo, $isChange:true
                    (newVal)->
                            _.forEach newVal, (item)->
                                new BlockinfoService(item).$update().then(
                                   (data)->
                                      _.extend item,data
                                      item.$isChange = false
                                )
                            # console.log 'new ', newVal
                    true
                )
            ]
        ]
    }