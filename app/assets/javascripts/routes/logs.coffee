Pluto.LogsRoute = Em.Route.extend
  model: (params) ->
    # Making the controller accessible immidiately
    @controller = @controllerFor('logs')

    # Verifying a timeframe exists
    @setInitialParams(params) unless @hasParams(params)

    @controller.getLogsFor
      profile_url: params.profile_url
      start_date: @controller.get('start_date')
      end_date: @controller.get('end_date')
      return_model: true

  setInitialParams: (params) ->
    @controller.set 'start_date', moment().subtract({ days: 30 }).format('YYYY-MM-DD')
    @controller.set 'end_date', moment().format('YYYY-MM-DD')
    @controller.set 'profile_url', params.profile_url

  hasParams: (params) ->
    @hasTimeframe() and @hasCorrectProfile(params.profile_url)

  hasTimeframe: ->
    @controller.get('start_date') and @controller.get('end_date')

  hasCorrectProfile: (profile_url) ->
    @controller.get('profile_url') and @controller.get('profile_url') is profile_url
