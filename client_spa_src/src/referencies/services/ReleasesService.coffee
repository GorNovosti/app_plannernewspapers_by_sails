define ['cs!./services'],(module)->
    module.factory 'ReleasesService', ['$resource','baseUrl',($resource,baseUrl)->
        return $resource "#{baseUrl}/releasenewspapers/:id", {"id":"@id"},
            update:
                method: 'PUT'
            query:
                isArray: true
            get:
                isArray: false
    ]