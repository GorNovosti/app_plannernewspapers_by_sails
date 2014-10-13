###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'cs!./../namespace'
    'text!./draggable.tpl.html' ##TODO: must change default template on module name template
], (module
    namespace
    tplIndex)->
     
    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/draggable.tpl.html", tplIndex
        ##NOTE: name "index.tpl.html" must be in the $stateProvider.state
        return
    ]