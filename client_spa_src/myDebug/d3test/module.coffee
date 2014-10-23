define [
    'angular'
    'cs!./config'
    'd3'
    'angular-ui-router'
    'angular-ui-router.stateHalper'
],(
    angular
    config
    d3module
)->
    _module = angular.module( config.namespace ,['ui.router','ui.router.stateHelper'])
    _module.run([->
        console.info "run #{config.namespace}"
    ])
    _module.config [ 'stateHelperProvider',(stateHelperProvider)->
        if !!config.states
            angular.forEach config.states, (_state)->
                stateHelperProvider.setNestedState(_state)
                return
    ]
    _module.factory 'd3Service',[->
        return d3module
    ]
    _module.directive 'd3SvgTest',['d3Service',(d3)->
        return {
            requeri: '^ngModel'
            restrict: 'E'
            replace: true
            template : '<div>{{data}}<style>svg{border:solid 1px}</style></div>'
            scope:
                data:'=ngModel'
            controller: ($scope)->
                $scope.onClick = (e)->
                    console.log 'e',e
            link: (scope,element,attrs)->
                el = element[0]
                svg = d3.select(element[0]).append("svg")
                    .attr("width", "100%")
                    .attr("height", "100%")
                    .attr("viewBox", "0 0 297 410")
                    .attr("class", "overlay")

                console.log 'data build', scope.data

                groupBlockInfos = svg.selectAll("g.chart")

                box = groupBlockInfos
                    .data(scope.data).enter()
                    .append("g").classed("chart",true)
                    .append("rect").classed("box", true)
                    .attr("width", 100)
                    .attr(
                        id: (d)-> "box#{d.id}"
                        x: (d)-> d.x
                        y: (d)-> d.y
                    )
                    .attr("height", 100)
                    .style("fill",'#f2f2f2')
                ##handle Drag
                handleDragBlockinfo = d3.behavior.drag().on('dragstart', (d,i)->
                        console.log d,i
                    )
                #resizer =
                box.call(handleDragBlockinfo)
        }

    ]

    return _module