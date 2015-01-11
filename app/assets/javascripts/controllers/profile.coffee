Pluto.ProfileController = Em.Controller.extend
  needs: ['user', 'logs']

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

  totalHours: Em.computed ->
    @formattedTime @get('controllers.logs.totalTime')
  .property('controllers.logs.totalTime')

  offsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.offsiteTime')
  .property('controllers.logs.offsiteTime')

  onsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.onsiteTime')
  .property('controllers.logs.onsiteTime')

  formattedTime: (total_minutes) ->
    hours = Math.floor(total_minutes / 60)
    minutes = total_minutes % 60

    hours_string = "#{hours} hours"
    minutes_string = if minutes then " and #{minutes} minutes" else ''

    hours_string + minutes_string
