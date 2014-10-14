###
Namespace module
###
define [], ->
    parent_namespace = "common"
    _default_namespace = "security"
    return "#{parent_namespace}.#{_default_namespace}"