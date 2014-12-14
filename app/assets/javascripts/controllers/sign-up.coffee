Pluto.SignUpController = Em.Controller.extend
  needs: ['user']

  actions:
    signUp: ->
      @clearCurrentErrors()
      @signupRequest().then $.proxy(@, 'processNewUser')

  signupRequest: ->
    form_fields = @get('form').serializeArray()
    request =
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    for field in form_fields
      request[field.name] = field.value

    $.ajax
      url: '/users'
      type: 'post'
      data: request

  processNewUser: (data) ->
    if data.success
      if data.inactive_message
        @displayServerErrors data.inactive_message
      else
        @set 'controllers.user.content', Pluto.User.create data.user
        @transitionToRoute 'index'
    else
      @displayServerErrors data.errors

  clearCurrentErrors: ->
    $('#signup-form p.error').remove()

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
