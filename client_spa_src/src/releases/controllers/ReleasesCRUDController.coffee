define ['cs!./controllers','cs!./../config'],(module,config)->
    module.controller 'ReleasesCRUDController',[
        '$scope'
        '$modal'
        'ReleasesService'
        ($scope,$modal,ReleasesService,$sails)->
            $scope.note = ''
            ## Create new Release
            $scope.listReleases =  ReleasesService.query()
            $scope.release = new  ReleasesService()
            ## Create new Release
            $scope.onCreate = $scope.onEdit = (item = null )->
                    $scope.release = item if !!item
                    console.log $scope.release
                    $modal.open(
                            windowClass: 'addModal'
                            templateUrl: "templates/#{config.namespace.replace /\.+/g, "/"}/release_form_modal.tpl.html"
                            resolve:
                                entity: ->
                                    return $scope.release
        #                        isNew: ->
        #                            console.log item? true || false
        #                            if item?
        #                                return false
        #                            else
        #                                return true
                            controller: ['$scope','$modalInstance','entity',($scope,$modalInstance,entity)->
                                 $scope.entity = angular.copy entity
                                 $scope.onCancel = ->
                                    $modalInstance.dismiss('cancel')
                                 $scope.onSave = (_entity= null)->
                                     $scope.isBusy = true
                                     console.log $scope.release
                                     console.log _entity

                                     _.extend $scope.release, {name:_entity.name,pagesCount:_entity.pagesCount}

                                     _method = if $scope.release.id then '$update' else '$save'
                                     $scope.release[_method]().then(
                                        (data)->
                                            console.log data
                                        (err)->
                                            console.log err
                                     )
                                     console.log _method

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