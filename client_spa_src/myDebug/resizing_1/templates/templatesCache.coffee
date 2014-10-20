###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./resizing.tpl.html'
], (module
    tplRoot)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/resizing.tpl.html", tplRoot
    ]