define [],()->
    _namespace = 'releases'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            controller: 'ReleasesCRUDController'
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/releases.tpl.html"# _namespace+'/templates/defaultscreen.tpl.html'# '<section ui-view><a href="#test2">test2</a></section>'
            data:
                pageTitle:  "Выпуски газет"

    ]
    }