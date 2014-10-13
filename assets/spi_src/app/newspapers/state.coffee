###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define ['cs!./../namespace'],(namespace)->
    return {
        name: 'newspapers'
        url:'release'
        templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/newspapers.tpl.html"
    }
