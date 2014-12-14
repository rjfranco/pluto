Pluto.SignInController = Em.Controller.extend
  needs: ['user']

  actions:
    signIn: ->
      email    = $('#email').val()
      password = $('#password').val()

      @get('controllers.user').signIn(email, password).then (data) =>
        if data.success
          @transitionToRoute 'index'
        else
          @displayServerErrors data.errors

  displayServerErrors: (errors) ->
    for key in Object.keys(errors)
      $field = $("##{key}")
      message = """
        <p class="error">#{key.capitalize().replace(/\_/, ' ')} #{errors[key]}</p>
      """
      if $field.length
        $field.after message
      else
        $('#signup-form').prepend message
