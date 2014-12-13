Pluto.UserController = Em.Controller.extend
  signOut: ->
    $.ajax
      url: '/users/sign_out'
      type: 'delete'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
    .then =>
      @set 'content', undefined
