# earth radius in km
R = 6371

to_rad = (angle) ->
  angle * Math.PI / 180

class exports.GPX
  constructor: (string) ->
    undefined

class exports.Point
  constructor: (@lon, @lat, @ele) ->

exports.distance2d = (a, b) ->
  # haversine
  dLat = to_rad (b.lat - a.lat)
  dLon = to_rad (b.lon - a.lon)
  lat1 = to_rad a.lat
  lat2 = to_rad b.lat
  a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
  R * c
