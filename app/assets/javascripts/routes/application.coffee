Pluto.ApplicationRoute = Em.Route.extend
  beforeModel: ->
    # This data needs to be available globally
    @setupAppURIs()

  setupAppURIs: ->
    $.get('/app-uris').then (data) =>
      Pluto.URIs = data
