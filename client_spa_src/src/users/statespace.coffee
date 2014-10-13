###
Statespace
###
define [], ()->
    _default_statespace_name = 'users' ##default statespace name
    return {
        name: "#{_default_statespace_name}"
        url: "/#{_default_statespace_name}"
        pageTitle: "Users Management"
    }