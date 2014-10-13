###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./pageedit_index.tpl.html'
], (module
    tplRoot)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/pageedit_index.tpl.html", tplRoot
    ]