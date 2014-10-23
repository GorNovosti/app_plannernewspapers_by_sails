define [],()->
    _namespace = 'home'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/home.tpl.html"# _namespace+'/templates/defaultscreen.tpl.html'# '<section ui-view><a href="#test2">test2</a></section>'
        ]
    }