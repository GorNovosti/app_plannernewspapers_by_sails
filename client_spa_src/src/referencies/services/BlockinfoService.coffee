define ['cs!./services'],(module)->
    module.factory 'BlockinfoService', ['$resource','baseUrl',($resource,baseUrl)->
        return $resource "#{baseUrl}/blockinfo/:id", {"id":"@id"},
            update:
                method: 'PUT'
            get:
                isArray: false
            query:
                isArray: true
    ]