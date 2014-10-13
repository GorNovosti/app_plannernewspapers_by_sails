define ['cs!./../config','angular'],(config,angular)->
    _module = angular.module config.namespace+'.services', []
    return _module