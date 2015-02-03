Pluto.WeeklyHoursView = Em.View.extend
  templateName: 'weekly-hours'
  didInsertElement: ->
    @set 'controller.weekly-hours-container', @$('.weekly-hours-table')
    @get('controller.weekly-hours-container').slideDown('fast')
