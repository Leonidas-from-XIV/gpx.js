jsdom = require 'jsdom'
# earth radius in km
R = 6371
# trying to use equatorial radius instad for now
# R = 6378.1

to_rad = (angle) ->
  angle * Math.PI / 180

class exports.GPX
  constructor: ->
    undefined

  parseString: (xml, cb) =>
    jsdom.env xml.toString(), (err, window) ->
      trkpts = window.document.getElementsByTagName 'trkpt'
      result = []
      for item in trkpts
        lon = parseFloat item.getAttribute('lon')
        lat = parseFloat item.getAttribute('lat')
        elevation = item.getElementsByTagName('ele')[0]
        ele = parseFloat elevation.firstChild.nodeValue
        result.push {lat: lat, lon: lon, ele: ele}
      cb undefined, result

class exports.Point
  constructor: (@lat, @lon, @ele) ->

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

exports.distance3d = (a, b) ->
  planar = exports.distance2d a, b
  height = Math.abs a.ele - b.ele
  # wacky CoffeeScript precedence rules
  Math.sqrt Math.pow(planar, 2) + Math.pow height, 2
