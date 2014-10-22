###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./referencies.tpl.html'
    'text!./blockinfo_list.tpl.html'
    'text!./form.blockinfo.tpl.html'

    'text!./release_list.tpl.html'
    'text!./form.release.tpl.html'

], (module
    tplRoot
    tplBlockinfoList 
    tplBlockinfoForm
    tplReleaseList
    tplReleaseForm
)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/referencies.tpl.html", tplRoot
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/blockinfo_list.tpl.html", tplBlockinfoList
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/form.blockinfo.tpl.html", tplBlockinfoForm

        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/release_list.tpl.html", tplReleaseList
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/form.release.tpl.html", tplReleaseForm
    ]