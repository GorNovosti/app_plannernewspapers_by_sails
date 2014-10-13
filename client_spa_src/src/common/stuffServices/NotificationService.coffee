###
NotificationService
###
define [
    'cs!./../module'
    'angularjs-toaster'
], (module) ->
    module.factory 'NotificationService', [
        'toaster'
        (toaster) ->
            error: (title, text, settings = null) ->
                toaster.pop 'error', title, text

            info: (title, text, settings = null) ->
                toaster.pop 'info', title, text

            wait: (title, text, settings = null) ->
                toaster.pop 'wait', title, text

            success: (title = "Success", text, settings = null) ->
                toaster.pop 'success', title, text

            warning: (title, text, settings = null) ->
                toaster.pop 'warning', title, text

            getToaster: toaster
    ]