###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'text!./referencies.tpl.html'
    'text!./typeblockinfo_list.tpl.html'
    'text!./blockinfo_list.tpl.html'
], (module
    tplRoot
    tplTypeBlockinfoList
    tplBlockinfoList
)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/referencies.tpl.html", tplRoot
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/typeblockinfo_list.tpl.html", tplTypeBlockinfoList
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/blockinfo_list.tpl.html", tplBlockinfoList
    ]