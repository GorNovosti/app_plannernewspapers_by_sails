###*
* @descripion Директива просмотра содержания страницы(полосы) газеты

###
define [
    'cs!./directives'
],(
    module

)->
    module.controller 'ViewerPageNewspaperController',['$scope',($scope)->
                $scope.$isSelect = null
                $scope.setSelect = (node)->

                    $scope.$isSelect = node.id
                    $scope.nodeMouseDown = (evt,node)->
                        console.log node

            ]


    module.directive 'viewerPageNewspaper', [ ->
        return {
            require: '^ngModel'
            restrict: 'E'
            replace: true
            scope:
                model: "=ngModel"
            templateUrl:  "templates/#{module.name.replace /\.+/g, "/"}/viewer_page_newspaper.tpl.html"
            controller: 'ViewerPageNewspaperController'
        }


    ]