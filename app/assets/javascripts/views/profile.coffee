Pluto.ProfileView = Em.View.extend
  didInsertElement: ->
    @setupMainChart()
    @setupWeeklyChart()
    @setupDatePickers()

  setupMainChart: ->
    @setMainChartCanvasSize()
    ctx = $("#standard-report")[0].getContext '2d'
    data = @get('controller.controllers.logs').onsiteVsOffsiteReport()
    @set 'main_chart', new Chart(ctx).Pie data,
      segmentShowStroke: false
      tooltipTemplate: '<%= value %>%'
      showTooltips: true
      responsive: true

  setupWeeklyChart: ->
    @setupWeeklyChartCanvasSize()
    ctx = $('.last-week-report')[0].getContext '2d'
    data = @controller.get('last_week_stacked_bar_data')
    options =
      responsive: true
      barShowStroke: false
      scaleLineColor: 'rgba(255,255,255,.4)'
      scaleFontColor: '#fff'
    @set 'weekly_chart', new Chart(ctx).StackedBar data, options

  setMainChartCanvasSize: ->
    new_height = $('.pie-chart').innerHeight()
    new_width = $('.pie-chart').innerWidth()
    $("#standard-report").attr
      width: new_width
      height: new_height

  setupWeeklyChartCanvasSize: ->
    bar_chart_container = $('.stacked-bar-chart')

    new_width = bar_chart_container.innerWidth()
    new_height = bar_chart_container.innerHeight()

    bar_chart_container.find('.last-week-report').attr
      width: new_width
      height: new_height

  setupDatePickers: ->
    @setupDatePicker 'start-datepicker', 'start_date'
    @setupDatePicker 'end-datepicker', 'end_date'

  setupDatePicker: (name, value) ->
    controller = @get('controller')
    element = "##{name}-value"

    picker = $(element).pickadate
      hiddenName: true
      clear: false
      formatSubmit: 'yyyy-mm-dd'

    controller.set name, picker.pickadate('picker')

    controller.get(name).on 'close', =>
      controller.set value, controller.get(name).get('select', 'yyyy-mm-dd')
      @updateLogs() if @validDateRange()

  validDateRange: ->
    controller = @get('controller')
    moment(controller.get('start_date')).isBefore moment(controller.get('end_date'))

  updateLogs: ->
    logs_controller = @get('controller.controllers.logs')

    logs_controller.getLogsFor
      profile_url: @get('controller.model.profile_url')
      start_date: @get('controller.start_date')
      end_date: @get('controller.end_date')
    .then =>
      chart = @get('main_chart')
      data = logs_controller.onsiteVsOffsiteReport()

      chart.segments[0].value = data[0].value
      chart.segments[1].value = data[1].value

      chart.update()
