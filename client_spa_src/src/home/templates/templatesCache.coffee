###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./home.tpl.html' ##TODO: must change default template on module name template
], (module
    tplRoot)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/home.tpl.html", tplRoot 
    ]