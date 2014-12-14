Pluto.UserController = Em.Controller.extend
  signOut: ->
    $.ajax
      url: '/users/sign_out'
      type: 'delete'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
    .then (data) =>
      if data.success
        @set 'content', undefined
        @updateCSRFToken data.csrf
        data

  signIn: (email, password) ->
    $.ajax
      url: '/users/sign_in'
      type: 'post'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
        'user[email]': email
        'user[password]': password
    .then (data) =>
      if data.success
        @set 'content', Pluto.User.create(data.user)
        @updateCSRFToken data.csrf
        data

  updateCSRFToken: (csrf) ->
    $('meta[name=csrf-param]').attr 'content', csrf.param
    $('meta[name=csrf-token]').attr 'content', csrf.token
