Pluto.TimeManipulation = Em.Mixin.create
  formattedTime: (total_minutes) ->
    hours = Math.floor(total_minutes / 60)
    minutes = total_minutes % 60

    hours_string = "#{hours} hours"
    minutes_string = if minutes then " and #{minutes} min" else ''

    hours_string + minutes_string
