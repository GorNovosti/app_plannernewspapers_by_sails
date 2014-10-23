###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./index.tpl.html'
], (
    module
    tplIndex
)->
    console.log     "templates/#{module.name.replace /\.+/g, "/"}/index.tpl.html"
    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/index.tpl.html", tplIndex
    ]