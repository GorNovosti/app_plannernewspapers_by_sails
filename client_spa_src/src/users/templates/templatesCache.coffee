###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'cs!./../namespace'
    'text!./relevanousers.tpl.html'
    'text!./form.userprofile.tpl.html'
], (module
    namespace
    tplIndex
    tplUserForm
)->
    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/relevanousers.tpl.html", tplIndex
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/form.userprofile.tpl.html", tplUserForm
    ]