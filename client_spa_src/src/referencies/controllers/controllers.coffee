define ['cs!./../config','angular','cs!./../services/index'],(config,angular,services)->
    return angular.module config.namespace + '.controllers', [services]