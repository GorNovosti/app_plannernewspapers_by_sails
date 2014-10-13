### TimeZonesService ###
define ['cs!./../module'], (module)->
    module.factory 'TimeZonesService', ['$resource', 'baseUrl', ($resource, baseUrl)->
        resource = new $resource baseUrl + '/timezones/:id', {"id":"@timezoneId"}
        return  resource
    ]