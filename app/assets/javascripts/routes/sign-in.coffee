Pluto.SignInRoute = Em.Route.extend
  beforeModel: ->
    user_controller = @controllerFor 'user'
    if !!user_controller.get('content')
      @transitionTo 'index'
