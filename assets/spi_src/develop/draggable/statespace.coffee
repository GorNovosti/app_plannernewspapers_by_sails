###
Statespace
###
define ['cs!./../statespace'], (parent_statespace)->
    _default_statespace_name = '_module' ##default statespace name
    return {
    name: "#{parent_statespace.name}.#{_default_statespace_name}" # state name for current module
    url: "/#{_default_statespace_name}" ## default url for call state
    pageTitle: "Module #{_default_statespace_name}" ## default page title
    }