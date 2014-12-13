Pluto.ApplicationRoute = Em.Route.extend
  beforeModel: ->
    # This data needs to be available globally
    @checkForAuthentication()

  checkForAuthentication: ->
    $.ajax
      url: '/users/current'
      type: 'get'
    .then (data) =>
      if data.user
        user_controller = @controllerFor 'user'
        user_controller.set 'content', Pluto.User.create(data.user)
