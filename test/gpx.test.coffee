gpx = require '../lib/gpx'
assert = require 'assert'

module.exports =
  'test distance in 2D': (test) ->
    a = new gpx.Point 23, 42, 0
    a_high = new gpx.Point 23, 42, 200
    b = new gpx.Point 23.5, 42.5, 0
    # same point
    assert.equal 0, gpx.distance2d a, a
    # same point, different height
    assert.equal 0, gpx.distance2d a, a_high
    # different points
    assert.equal 23, gpx.distance2d a, b
    test.finish()
