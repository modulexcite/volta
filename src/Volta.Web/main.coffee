require.config
    paths:
        "jquery": "scripts/jquery/jquery"
        "underscore": "scripts/underscore/underscore"
        "backbone": "scripts/backbone/backbone"
        "text": "scripts/require/text"
        "postal": "scripts/postal/postal"
        "postalajax": "scripts/postal/postal.ajax-events"
        "postalscroll": "scripts/postal/postal.window-scroll-events"
        "mustache": "scripts/mustache"

plugins = [
    'scripts/jquery/jquery.ajax-date-parser', 
    'scripts/jquery/jquery.cache-ajax-deferreds',
    'scripts/jquery/jquery.form',
    'scripts/bootstrap/bootstrap', 
    'scripts/bootstrap/bootstrap.dialog', 
    'scripts/bootstrap/bootstrap.validate',
    'scripts/underscore/underscore.mustache', 
    'scripts/backbone/backbone.lazy',
    'scripts/moment']

require ['jquery', 'backbone', 'postal', 'postalajax', 'postalscroll', 'app', 'batches/app', 'admin/app'].concat(plugins)
        , ($, Backbone, postal, postalAjax, postalScroll, App, Batches, Admin) ->
    
    window.onerror = (message, source, line) -> 
        $.post 'errors', { source: source, line: line, message: message }
        postal.publish('error', message: 'Oops! A browser error has occured. This has been logged and will be fixed as soon as possible.')

    postalAjax.errors[0] = 
        message: 'Unable to communicate with the server. Make sure you are connected to the internet and try again.'
    postalAjax.errors[500] = 
        message: 'Oops! A server error has occured. This has been logged and will be fixed as soon as possible.'

    postalScroll.bottomOffset = 100

    content = $ '#content'

    App.start $('.navbar-fixed-top'), $('#messages'), content
    Admin.start content
    Batches.start content

    Backbone.history.on 'route', -> postal.publish('route', window.location.hash.substr(1))
    Backbone.history.start()