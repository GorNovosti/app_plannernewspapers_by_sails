###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'cs!./../namespace'
    'text!./index.tpl.html'
    'text!./signin_form.tpl.html'
    'text!./header.tpl.html'
    'text!./toolbar.tpl.html'
], (module
    namespace
    tplIndex
    tplSigninForm
    tplHeader
    tplToolbar
)->
    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/index.tpl.html", tplIndex
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/signin_form.tpl.html", tplSigninForm
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/header.tpl.html", tplHeader
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/toolbar.tpl.html", tplToolbar
    ]