define ['cs!./../config','angular'],(config,angular)->
    console.log config
    _module = angular.module config.namespace+'.services', []
    return _module