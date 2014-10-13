###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./root.tpl.html'
], (module
    tplIndex)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/navbar.tpl.html", tplIndex
    ]