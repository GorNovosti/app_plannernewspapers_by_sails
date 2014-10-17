define ['cs!./services'],(module)->
    module.factory 'TypesBlockinfoService', ['$resource','baseUrl',($resource,baseUrl)->
        return $resource "#{baseUrl}/typesblockinfo/:id", {"id":"@id"},
            update:
                method: 'PUT' 
    ]