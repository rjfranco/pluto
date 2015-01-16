Pluto.UserMethods = Em.Mixin.create
  actions:
    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.model')
  .property('controllers.user.model')
