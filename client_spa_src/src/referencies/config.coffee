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
                templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/blockinfo_list.tpl.html"
            ,
                name: 'typeblockinfo'
                url: '/typeblockinfo'
                templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/typeblockinfo_list.tpl.html"
            ]

        ]
    }