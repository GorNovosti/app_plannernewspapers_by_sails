###
Cache content of template(s) with current name space
###
define [
    'cs!./../directives'
    'text!./viewer_page_newspaper.tpl.html'
], (module
    tplRoot 
)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/viewer_page_newspaper.tpl.html", tplRoot
    ]