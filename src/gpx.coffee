class exports.GPX
  constructor: (string) ->
    undefined

class exports.Point
  constructor: (@lon, @lat, @ele) ->

exports.distance2d = (a, b) ->
  lon_diff = Math.abs(a.lon - b.lon)
