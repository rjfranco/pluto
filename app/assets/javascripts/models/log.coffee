Pluto.Log = Em.Object.extend Pluto.TimeManipulation,
  displayDate: Em.computed ->
    moment(@get('date')).format('MMM Do')
  # .property('date')

  displayTime: Em.computed ->
    @formattedTime @get('time')
  # .property('time')

  location: Em.computed ->
    if @get('remote') then 'On-site' else 'Off-site'
  # .property('remote')
