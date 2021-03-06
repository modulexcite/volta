define ['backbone', 'jquery', 'postal'], (Backbone, $, postal) ->

    class View extends Backbone.View
        events:
            'click .login': 'login'
        initialize: (options) ->
            _.bindAll @, 'render', 'login', 'showError'
            postal.channel('error').subscribe (error) => @showError(error.message)
        render: ->
            @$('.username').focus()
        login: (event) ->
            event.preventDefault()
            @$('.login').attr('disabled', true)
            request =
                Username: @$('.username').val()
                Password: @$('.password').val()
            $.post('.', request)
                .success (response) =>
                    if response.Success then window.location = '/'
                    else 
                        @showError 'Your username or password was not valid.'
                        @$('.password').select()
                .error (response) => 
                    @showError if response.status == 500 then 'A system error has occured.' else 'Unable to access the server.'
                .complete => @$('.login').attr('disabled', false)
        showError: (message) ->
            errorMessage = @$('.login-error-message')
            if errorMessage.is(":visible") then return
            errorMessage.text(message)
            errorMessage.fadeIn 'slow'
            errorMessage.delay(2000).fadeOut('slow')

    View: View