define [
    'angular'
    'cs!./config'
    'cs!./directives/index'
    'angular-ui-router'
    'angular-ui-router.stateHalper'
    'angular-bootstrap-colorpicker'
    'angular-sails-bind'
],(
    angular
    config
    directivesModule
)->
    _module = angular.module( config.namespace ,['ui.router','ui.router.stateHelper','ui.bootstrap',directivesModule,'colorpicker.module','ngSailsBind'])
    _module.run([->
        console.info "run #{config.namespace}"
    ])
    _module.config [ 'stateHelperProvider',(stateHelperProvider)->
        if !!config.states
            angular.forEach config.states, (_state)->
                stateHelperProvider.setNestedState(_state)
                return
    #    _module.filter 'pagenewspaper', ->
    #       return  (inputArray,filterCriteria)->
    #            return  !filterCriteria || !angular.equals(item,filterCriteria);
    ]
    return _module