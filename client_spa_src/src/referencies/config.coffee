define [],()->
    _namespace = 'referencies'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            abstract: true
            url: '^/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/referencies.tpl.html"
            children: [
                name: 'blockinfo'
                url: '/blockinfo'
                controller: "BlockinfoCRUDController"
                templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/blockinfo_list.tpl.html"
                resolve:
                    APIService:[ "BlockinfoService",(BlockinfoService)->
                        return BlockinfoService
                    ]
                    tplForm: [ ->  "blockinfo"]# {tplForm: "templates/#{config.namespace.replace /\.+/g, "/"}/form.blockinfo.tpl.html"}

                data:
                   pageTitle: "Шаблоны информационных блоков"
            ,
                name: 'typeblockinfo'
                url: '/typeblockinfo'
                controller: "BlockinfoCRUDController"
                resolve:
                    APIService:[ "TypesBlockinfoService",(TypesBlockinfoService)->
                        return TypesBlockinfoService
                    ]
                    tplForm: [ -> 'typeblockinfo']#{"tplForm": "templates/#{config.namespace.replace /\.+/g, "/"}/form.typeblockinfo.tpl.html"}]
                templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/typeblockinfo_list.tpl.html"
                data:
                   pageTitle: "Типы информационных блоков"
            ,
                name: 'releases'
                url: '^/releaseslist'
                controller: "BlockinfoCRUDController"
                resolve:
                    APIService:[ "ReleasesService",(ReleasesService)->
                        return ReleasesService
                    ]
                    tplForm: [ -> 'release']
                templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/release_list.tpl.html"
                data:
                   pageTitle: "Рилизы "
            ]

        ]
    }