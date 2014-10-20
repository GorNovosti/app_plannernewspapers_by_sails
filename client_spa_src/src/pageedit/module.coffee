define [
    'angular'
    'cs!./config'
    'cs!./directives/index'
    'angular-ui-router'
    'angular-ui-router.stateHalper'
    'angular-bootstrap-colorpicker'
],(
    angular
    config
    directivesModule

)->
    _module = angular.module( config.namespace ,['ui.router','ui.router.stateHelper','ui.bootstrap',directivesModule,'colorpicker.module'])
    _module.run([->
        console.info "run #{config.namespace}"
    ])
    _module.config [ 'stateHelperProvider',(stateHelperProvider)->

        if !!config.states
            angular.forEach config.states, (_state)->
                stateHelperProvider.setNestedState(_state)
                return

    ]
    return _module