Pluto.LogsController = Em.ArrayController.extend
  getLogsFor: (profile_url) ->
    $.ajax
      url: '/logs'
      type: 'get'
      dataType: 'json'
      data:
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
        profile_url: profile_url
    .then (data) =>
      logs = for log in data
        Pluto.Log.create(log)
      @set 'model', logs

  onsiteVsOffsiteReport: ->
    onsite_log = @filterProperty 'remote', false
    offsite_log = @filterProperty 'remote', true

    onsite_count = 0
    offsite_count = 0

    for log in onsite_log
      onsite_count += log.get('time')

    for log in offsite_log
      offsite_count += log.get('time')

    [
      {
        value: onsite_count
        label: 'On-site'
        color: '#159de4'
        highlight: '#078ed4'
      },
      {
        value: offsite_count
        label: 'Off-site'
        color: '#c6ebfe'
        highlight: '#acd9f1'
      }
    ]
