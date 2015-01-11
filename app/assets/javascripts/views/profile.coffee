Pluto.ProfileView = Em.View.extend
  didInsertElement: ->
    @setupMainChart()

  setupMainChart: ->
    ctx = $("#standard-report")[0].getContext '2d'
    data = @controller.get('controllers.logs').onsiteVsOffsiteReport()
    @set 'main_chart', new Chart(ctx).Pie data,
      segmentShowStroke: false
