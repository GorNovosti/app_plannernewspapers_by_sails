###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define ['cs!./draggable/state'],(children_state)->
    return {
        name: 'root'
        url: '/test'
        template: '<section ui-view><a href="/test/draggable">test/draggable</a></section>'
        children: [
            children_state
        ]

    }
