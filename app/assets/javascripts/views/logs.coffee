Pluto.LogsView = Em.View.extend
  didInsertElement: ->
    @setupDatePickers()

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

    controller.getLogsFor
      profile_url: controller.get('profile_url')
      start_date: controller.get('start_date')
      end_date: controller.get('end_date')
