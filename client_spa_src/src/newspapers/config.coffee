define [],()->
    _namespace = 'newspapers'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'
            controller: 'NewspapersListController'
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/root.tpl.html" 
            children: [
                name: 'release'
                url: '^/release/:id'
                template: '<section ui-view><a href="#test1">go to "root1"</a></section>'
            ]

        ]
    }