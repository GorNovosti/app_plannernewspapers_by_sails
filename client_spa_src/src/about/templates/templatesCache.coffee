###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./about.tpl.html'
], (module
    tplRoot)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/about.tpl.html", tplRoot
    ]