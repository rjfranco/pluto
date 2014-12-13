Pluto.IndexController = Em.Controller.extend
  needs: ['user']

  actions:
    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.content')
  .property('controllers.user.content')
