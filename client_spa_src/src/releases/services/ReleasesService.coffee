define ['cs!./services'],(module)->
    module.factory 'ReleasesService', ['$resource',($resource)->
        return $resource 'http://localhost:1337/api/v1/releasenewspapers/:id', {"id":"@id"},
            update:
               method: 'PUT'
    ]