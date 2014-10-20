###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./pageedit_index.tpl.html'
    'text!./form.blockinfo.tpl.html'
], (module
    tplRoot
    tplFormBlockinfo
)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/pageedit_index.tpl.html", tplRoot
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/form.blockinfo.tpl.html", tplFormBlockinfo

    ]