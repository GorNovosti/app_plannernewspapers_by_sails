define ['cs!./controllers','cs!./../config'],(module,config)->

    module.controller 'BlockinfoCRUDController',  [
        '$scope'
        '$filter'
        '$modal'
        'APIService'
        'DialogService'
        'ngTableParams'
        'tplForm'
        ($scope, $filter,$modal,APIService,DialogService, ngTableParams,tplForm)->
            console.log tplForm
            ###
            Create ngTableParams
            ###
            $scope.tableParams = new ngTableParams
                page: 1
                count: 10
                sorting:
                    name: 'asc'  # special settings for this table
            ,
                total: 0, # length of data
                getData: ($defer, params)->
                    paramSend =
                        sort: params.orderBy().join()
                        limit: params.count()
                        page: params.page()
                    _.extend paramSend , angular.copy params.filter()
                    APIService.query( paramSend,
                        (result,p)->
                            # update table params
                            params.total(p()['x-prism-total-items-count'])
                            #set new data
                            $defer.resolve result
                        (result)->
                            $defer.resolve()# resolve

                    )
                $scope: $scope.$new()
            ###* confirm delete (used service) ###
            $scope.onDeleteUser = (item)->
                delDlg = DialogService.deleteDialog "Удаление","Вы действительно желаете удалить запись с именем <strong>#{item.name}</strong>?"
                delDlg.result.then(
                    ##confirn delete entity
                    (res)->
                        $scope.isBusy = true
                        item.$delete().then(
                            (result)->
                                $scope.isBusy = false
                                $scope.tableParams.reload()
                                #$modalInstance.close(null)
                            (error)->
                                $scope.isBusy = false
                        )
                )
            ###* Add new User or Edit them in modal window###
            $scope.onEditUser = $scope.onAddUser = (item = null)->
                console.log 'start ', item
                $modal.open(
                    windowClass: 'addModal'
                    templateUrl: "templates/#{config.namespace.replace /\.+/g, "/"}/form.#{tplForm}.tpl.html"
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
                            console.log 'entity',isNew,entity

                            if isNew
                                $scope.currEntity = null
                                $scope.editEntity = new APIService(entity)
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
                                            $scope.tableParams.reload()
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
                        console.log result ,'=?=',item
                        if item?
                            _.extend item , result
                    (result)->
                        console.log result

                )
    ]