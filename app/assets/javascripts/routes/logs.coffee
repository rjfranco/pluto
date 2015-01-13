Pluto.LogsRoute = Em.Route.extend
  model: (params) ->
    # Making the controller accessible immidiately
    @controller = @controllerFor('logs')

    # Verifying a timeframe exists
    @setInitialTimeframe() unless @hasTimeframe()

    @controller.getLogsFor
      profile_url: params.profile_url
      start_date: @controller.get('start_date')
      end_date: @controller.get('end_date')
      return_model: true

  setInitialTimeframe: ->
    @controller.set 'start_date', moment().subtract({ days: 30 }).format('YYYY-MM-DD')
    @controller.set 'end_date', moment().format('YYYY-MM-DD')

  hasTimeframe: ->
    @controller.get('start_date') and @controller.get('end_date')
