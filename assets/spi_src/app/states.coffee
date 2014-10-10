###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define ['cs!./about/state'],(about_state)->
    return {
        name: 'root'
        url: '/'
        template: '<section ui-view></section>'
        children: [
            about_state
        ]

    }
