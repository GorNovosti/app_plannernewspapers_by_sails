###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define [
    'cs!./about/state'
    'cs!./newspapers/state'
],(
    about_state
    newspapers_state
)->
    return {
        name: 'root'
        url: '/'
        template: '<section ui-view></section>'
        children: [
            about_state
            newspapers_state
        ]

    }
