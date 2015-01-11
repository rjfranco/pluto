Pluto.ProfileRoute = Em.Route.extend
  beforeModel: (params) ->
    logs_controller = @controllerFor 'logs'
    logs_controller.getLogsFor params.profile_url
