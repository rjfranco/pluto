Pluto.ProfileRoute = Em.Route.extend
  beforeModel: (transition) ->
    # Making the controller accessible immidiately
    @profile_controller = @controllerFor('profile')

    # Verifying a timeframe exists
    @setInitialTimeframe() unless @hasTimeframe()

    # Retrieving log data through logs array controller
    logs_controller = @controllerFor 'logs'

    logs_controller.getLogsFor
      profile_url: transition.params.profile.profile_url
      start_date: @profile_controller.get('start_date')
      end_date: @profile_controller.get('end_date')

  setInitialTimeframe: ->
    @profile_controller.set 'start_date', moment().subtract({ days: 30 }).format('YYYY-MM-DD')
    @profile_controller.set 'end_date', moment().format('YYYY-MM-DD')

  hasTimeframe: ->
    @profile_controller.get('start_date') and @profile_controller.get('end_date')
