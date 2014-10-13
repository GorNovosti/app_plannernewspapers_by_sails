define ['cs!./../config','angular','cs!./../services/services'],(config,angular,services)->
    return angular.module config.namespace + '.controllers', [services["name"]]