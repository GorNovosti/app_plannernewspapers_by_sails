###
Blcokinfo templates
###
define ['cs!./services'],(module)->
    module.factory 'BlockinfoTemplatesService', ['$resource','baseUrl',($resource,baseUrl)->
        return $resource "#{baseUrl}/blockinfotemplate/:id", {"id":"@id"},
            update:
                method: 'PUT'
            get:
                isArray: false
            query:
                isArray: true
    ]