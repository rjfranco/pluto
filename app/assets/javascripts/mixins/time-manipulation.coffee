Pluto.TimeManipulation = Em.Mixin.create
  formattedTime: (total_minutes) ->
    hours = Math.floor(total_minutes / 60)
    minutes = total_minutes % 60

    hours_string = "#{hours} hours"
    minutes_string = if minutes then " and #{minutes} min" else ''

    hours_string + minutes_string

  shortTime: (total_minutes) ->
    console.log 'Total minutes?', total_minutes
    hours = Math.floor(total_minutes / 60)
    minutes = total_minutes % 60
    if minutes.toString().length is 1
      minutes = "0#{minutes}"

    "#{hours}:#{minutes}"
