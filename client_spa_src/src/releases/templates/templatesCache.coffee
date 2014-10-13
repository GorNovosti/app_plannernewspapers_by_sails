###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./releases.tpl.html'
    'text!./release_form_modal.tpl.html'
], (module
    tplRoot
    tplFormModal
)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/releases.tpl.html", tplRoot
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/release_form_modal.tpl.html", tplFormModal
    ]