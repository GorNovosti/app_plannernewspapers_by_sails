###
Cache content of template(s) with current name space
###
define [
    'cs!./../module'
    'cs!./../namespace'
    'text!./about.tpl.html' ##TODO: must change default template on module name template
], (
    module
    namespace
    tplIndex
)->
    console.log module
    module.run ['$templateCache', ($templateCache)->
        $templateCache.put "templates/#{namespace.replace /\.+/g, "/"}/about.tpl.html", tplIndex
        ##NOTE: name "index.tpl.html" must be in the $stateProvider.state
    ]