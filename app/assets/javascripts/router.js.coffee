# For more information see: http://emberjs.com/guides/routing/

Pluto.Router.reopen
  location: 'history'

Pluto.Router.map ->
  @route 'sign-up'
  @route 'sign-in'
  @route 'profile', { path: '/profile/:profile_url' }
  @route 'logs', { path: '/entries/:profile_url' }
