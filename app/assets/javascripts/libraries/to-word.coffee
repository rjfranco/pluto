Number::toWord = ->
  units = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
  tens = ["Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]

  theword = ""
  int_number = this.valueOf()

  return "Lots" if int_number > 999
  return units[0] if int_number is 0

  for num in [9..1]
    hundreds_place = num * 100
    if int_number >= hundreds_place
      theword += units[num]
      started = 1
      theword += " hundred"
      theword += " and "  unless int_number is hundreds_place
      int_number -= hundreds_place

  for num in [9..2]
    tens_place = num * 10
    if int_number >= tens_place
      theword += if started then tens[num - 2].toLowerCase() else tens[num - 2]
      started = true
      theword += "-" unless int_number is tens_place
      int_number -= tens_place

  for num in [1..19]
    if int_number == num
      theword += if started then units[num].toLowerCase() else units[num]

  theword
