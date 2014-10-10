###
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
###
define ['cs!./../namespace'],(namespace)->
    return {
        name: 'about'
        url:'about'
        templateUrl: "templates/#{namespace.replace /\.+/g, "/"}/about.tpl.html"
    }
