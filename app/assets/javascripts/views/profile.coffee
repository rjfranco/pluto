Pluto.ProfileView = Em.View.extend
  didInsertElement: ->
    @setupMainChart()

  setupMainChart: ->
    @setMainChartCanvasSize()
    ctx = $("#standard-report")[0].getContext '2d'
    data = @controller.get('controllers.logs').onsiteVsOffsiteReport()
    @set 'main_chart', new Chart(ctx).Pie data,
      segmentShowStroke: false
      tooltipTemplate: '<%= value %>%'
      onAnimationComplete: ->
        @showTooltip @segments, true
      tooltipEvents: []
      showTooltips: true

  setMainChartCanvasSize: ->
    new_height = $('.percentage').height() - $('.percentage header').height() - $('.percentage .date-selector').height() - 64
    new_width = $('.percentage').width() - 64
    $("#standard-report").attr
      width: new_width
      height: new_height
