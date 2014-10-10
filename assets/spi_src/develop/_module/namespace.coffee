###
Namespace module
###
define ['cs!./../namespace'], (parent_namespace)->
    _default_namespace = '_module' #NOTE: default namespace is name folder
    return parent_namespace + '.' + _default_namespace