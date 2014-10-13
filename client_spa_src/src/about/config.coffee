define [],()->
    _namespace = 'about'
    return {
        namespace: _namespace
        states:[
            name: _namespace
            url: '/'+_namespace
            templateUrl: "templates/#{_namespace.replace /\.+/g, "/"}/about.tpl.html" 
        ]
    }