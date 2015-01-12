Pluto.LogsController = Em.ArrayController.extend
  getLogsFor: (options) ->
    $.ajax
      url: '/logs'
      type: 'get'
      dataType: 'json'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
        profile_url: options.profile_url
        start_date: options.start_date
        end_date: options.end_date
    .then (data) =>
      logs = for log in data
        Pluto.Log.create(log)
      @set 'model', logs

  totalTime: Em.computed ->
    @reduce (previousTotal, log) ->
      previousTotal + log.get('time')
    , 0
  .property('@each')

  offsiteTime: Em.computed ->
    @reduce (previousTotal, log) ->
      if log.get('remote')
        previousTotal + log.get('time')
      else
        previousTotal
    , 0
  .property('@each')

  onsiteTime: Em.computed ->
    @get('totalTime') - @get('offsiteTime')
  .property('totalTime', 'offsiteTime')

  onsiteVsOffsiteReport: ->
    offsite_percentage = Math.round(@get('offsiteTime') / @get('totalTime') * 100)
    onsite_percent = 100 - offsite_percentage

    [
      {
        value: onsite_percent
        label: 'On-site'
        color: '#159de4'
        highlight: '#078ed4'
      },
      {
        value: offsite_percentage
        label: 'Off-site'
        color: '#c6ebfe'
        highlight: '#acd9f1'
      }
    ]
