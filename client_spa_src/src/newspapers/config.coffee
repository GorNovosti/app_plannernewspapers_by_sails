define [],()->
    _namespace = 'newspapers'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'
            controller: 'NewspapersListController'
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/root.tpl.html"# _namespace+'/templates/defaultscreen.tpl.html'# '<section ui-view><a href="#test2">test2</a></section>'
        #            resolve:
        #                test: ->
        #                    console.log 'test resolv'
        #                    return true
            children: [
                name: 'release'
                url: '^/release/:id'
                template: '<section ui-view><a href="#test1">go to "root1"</a></section>'
            ]

        ]
    }