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
    total_minutes = @get('controllers.logs').reduce (previousTotal, log) ->
      previousTotal + log.get('time')
    , 0

    @formattedTime total_minutes
  .property('controllers.logs.@each')

  offsiteHours: Em.computed ->
    total_minutes = @get('controllers.logs').reduce (previousTotal, log) ->
      if log.get('remote')
        previousTotal + log.get('time')
      else
        previousTotal
    , 0

    @formattedTime total_minutes
  .property('controllers.logs.@each')

  onsiteHours: Em.computed ->
    total_minutes = @get('controllers.logs').reduce (previousTotal, log) ->
      unless log.get('remote')
        previousTotal + log.get('time')
      else
        previousTotal
    , 0

    @formattedTime total_minutes
  .property('controllers.logs.@each')

  formattedTime: (total_minutes) ->
    hours = Math.floor(total_minutes / 60)
    minutes = total_minutes % 60

    hours_string = "#{hours} hours"
    minutes_string = if minutes then " and #{minutes} minutes" else ''

    hours_string + minutes_string
