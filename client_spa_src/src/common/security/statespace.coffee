###
Statespace
###
define [], ()->
    _default_statespace_name = "security" ##default statespace name
    return {
        name: "#{_default_statespace_name}" # state name for current module
        url: "^/login" ## default url for call state
        titlePage: 'Security'
    }