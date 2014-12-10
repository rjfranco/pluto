Pluto.SignUpController = Em.Controller.extend
  actions:
    signUp: ->
      @signupRequest().then (data) =>

  signupRequest: ->
    form_fields = @get('form').serializeArray()
    request =
      authenticity_token: $('meta[name=csrf-token]').attr('content')
    for field in form_fields
      request[field.name] = field.value

    console.log 'Request to send', request
    $.ajax
      url: '/users'
      type: 'post'
      data: request
