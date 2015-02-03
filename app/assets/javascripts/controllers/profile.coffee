Pluto.ProfileController = Em.Controller.extend Pluto.TimeManipulation, Pluto.UserMethods,
  needs: ['user', 'logs']

  actions:
    triggerCalendar: (picker) ->
      unless @get(picker).get('open')
        setTimeout =>
          @get(picker).open()
        , 0

    toggleWeeklyHours: ->
      if @get('weekly-hours-visible')
        @get('weekly-hours-container').slideUp 'fast', =>
          @set 'weekly-hours-visible', false
      else
        @set 'weekly-hours-visible', true

  formattedStartDate: Em.computed ->
    moment(@get('start_date')).format 'MMM Do'
  .property 'start_date'

  formattedEndDate: Em.computed ->
    if @get('end_date') is moment().format('YYYY-MM-DD')
      'Today'
    else
      moment(@get('end_date')).format 'MMM Do'
  .property 'end_date'

  totalHours: Em.computed ->
    @formattedTime @get('controllers.logs.totalTime')
  .property('controllers.logs.totalTime')

  offsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.offsiteTime')
  .property('controllers.logs.offsiteTime')

  onsiteHours: Em.computed ->
    @formattedTime @get('controllers.logs.onsiteTime')
  .property('controllers.logs.onsiteTime')

  weeklyHours: Em.computed ->
    {
      sunday: @hoursFromWeeklyDataSet(0)
      monday: @hoursFromWeeklyDataSet(1)
      tuesday: @hoursFromWeeklyDataSet(2)
      wednesday: @hoursFromWeeklyDataSet(3)
      thursday: @hoursFromWeeklyDataSet(4)
      friday: @hoursFromWeeklyDataSet(5)
      saturday: @hoursFromWeeklyDataSet(6)
    }
  .property('last_week_stacked_bar_data')

  hoursFromWeeklyDataSet: (position) ->
    bar_data = @get('last_week_stacked_bar_data')
    offsite_minutes = bar_data.datasets[0].data[position]
    onsite_minutes = bar_data.datasets[1].data[position]
    total_minutes = offsite_minutes + onsite_minutes

    {
      onsite: if onsite_minutes then @shortTime(onsite_minutes)
      offsite: if offsite_minutes then @shortTime(offsite_minutes)
      total: if total_minutes then @shortTime(total_minutes)
    }

  processWeeklyDataFor: (weekly_request) ->
    @set 'last_week_stacked_bar_data', {
      labels: [
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
      ]

      datasets: [
        {
          label: 'On-site'
          fillColor: '#159de4'
          highlightFill: '#078ed4'
          data: for day_of_week in [-7..-1]
            @weekdayTotalFromSet weekly_request[0],
              date: moment().weekday(day_of_week).format('YYYY-MM-DD')
              remote: false
        },
        {
          label: 'Off-site'
          fillColor: '#c6ebfe'
          highlightFill: '#acd9f1'
          data: for day_of_week in [-7..-1]
            @weekdayTotalFromSet weekly_request[0],
              date: moment().weekday(day_of_week).format('YYYY-MM-DD')
              remote: true
        }
      ]
    }

  weekdayTotalFromSet: (data, options) ->
    entries_total = 0

    if typeof options.remote is 'boolean'
      entries = data.filterProperty('date', options.date)?.filterProperty('remote', options.remote)
    else
      entries = data.filterProperty('date', options.date)

    for entry in entries
      entries_total += entry.time

    entries_total
