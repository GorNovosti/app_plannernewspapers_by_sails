define ['cs!./../config','cs!./controllers'],(config,module)->
    return module.controller  'NewspapersListController', [
        '$scope'
        ($scope)->

            $scope.listNewspapers = [
                id:1
                name: "Выпуск №1"
                pages:[
                    id:1
                    name: 'page1'
                    blocks:[]
                ,
                    id:2
                    name: 'page2'
                    blocks:[]
                ]
            ,
                id:2
                name: "Выпуск №2"
                pages:[
                    id:3
                    name: 'page3'
                    blocks:[]
                ]
            ]
            ## Select Active Realese Newspaper
            $scope.onClickReals = (item,_index)->
                console.log  item,_index
                $scope.listPages = item.pages
                return
            
    ]