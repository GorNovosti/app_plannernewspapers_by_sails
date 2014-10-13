###* ManageUsersService ###
define ['cs!./../module'],(module)->
    module.factory 'ManageUsersService',[
        '$q'
        '$resource'
        '$http'
        'baseUrl'
        ($q,$resource,$http,baseUrl)->
            _resource = $resource baseUrl+'/users/:id/:action',
                {"id":"@id"}
                    get:
                        method: "GET"
                    save:
                        method: "POST"
                    query:
                        method: "GET"
                        isArray: true
                        headers:
                            'X-Prism-Total-Items-Count': 'true'
                    update:
                        method: 'PUT'

                    updatePassword:
                        method: 'PUT'
                        params:
                            action: 'password'

                    delete:
                        method: 'DELETE',
                        headers:
                            'Content-Type': 'application/json'


            return  {
                query: _resource.query
                getUser: (params=null)->
                    user = new _resource(params)
                    user.$get() if !!params
                    return user
                getTimeZonesList: $resource(baseUrl+'/timezones').query
                getRolesList: $resource(baseUrl+'/roles').query

                                    #deffer = $q.defer()
                                    #$http.get(baseUrl+'/timezones'
                #                    TimeZonesService.$query(
                #                        (result)->
                #                            console.log 'TimeZonesService', result
                #                            deffer.resolve result
                #                    )
                                    #deffer.resolve []

                                    #return $resource(baseUrl+'/timezones').$query()# deffer.promise
            }

    ]