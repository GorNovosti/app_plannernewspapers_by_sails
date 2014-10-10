###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define [
    'cs!./namespace'
],(
    namespace
    LOG
)->
    _default_name = 'draggable'
    console.debug  LOG,"templates/#{namespace.replace /\.+/g, "/"}/#{_default_name}.tpl.html"
    return  {
        name: _default_name
        url: "/draggable"#{_default_name}"
        templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/draggable.tpl.html"
        controller: ['$scope',($scope)->
            $scope.onDragStart = (_event)->
                  console.log _event
            $scope.blockTemplates = [
                id:1
                name:"Статья "
            ,
                id:2
                name: "Реклама"
            ,
                id:3
                name: "Врезка"
            ]
        ]
    }
