###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    #'cs!./../namespace'
    'text!./root.tpl.html' ##TODO: must change default template on module name template
], (module
    #namespace
    tplRoot)->

    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{module.name.replace /\.+/g, "/"}/root.tpl.html", tplRoot
        ##NOTE: name "index.tpl.html" must be in the $stateProvider.state
    ]