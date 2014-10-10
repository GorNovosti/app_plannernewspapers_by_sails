###
    Entry point in module
###
define [
    'cs!./namespace'
    'cs!./module'
#    'cs!./templates/templatesCache'
], (namespace,n)->
    console.log n
    return namespace