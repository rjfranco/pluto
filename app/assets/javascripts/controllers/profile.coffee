Pluto.ProfileController = Em.Controller.extend
  needs: ['user']

  actions:
    # triggerCalendar: ->
    #   unless @get('datepicker').get('open')
    #     setTimeout =>
    #       @get('datepicker').open()
    #     , 0

    signOut: ->
      @get('controllers.user').signOut()

  userLoggedIn: Em.computed ->
    !!@get('controllers.user.model')
  .property('controllers.user.model')
