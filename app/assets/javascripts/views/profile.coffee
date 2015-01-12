Pluto.ProfileView = Em.View.extend
  didInsertElement: ->
    @setupMainChart()
    @setupDatePickers()

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
    controller = @get('controller')
    logs_controller = controller.get('controllers.logs')

    logs_controller.getLogsFor
      profile_url: controller.get('model.profile_url')
      start_date: controller.get('start_date')
      end_date: controller.get('end_date')
    .then =>
      chart = @get('main_chart')
      data = logs_controller.onsiteVsOffsiteReport()

      chart.data = data
      chart.update()
