# For more information see: http://emberjs.com/guides/routing/

Pluto.Router.reopen
  location: 'history'

Pluto.Router.map ()->
  # @resource('posts')
  @route 'sign-up'
  @route 'sign-in'
