Pluto.UserMethods = Em.Mixin.create
  actions:
    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.model')
  .property('controllers.user.model')

  profileURL: Em.computed ->
    user = @get('controllers.user.model')
    user?.get('profile_url')
  .property('controllers.user.model.profile_url')
