gpx = require '../lib/gpx'
assert = require 'assert'

assertSimilar = (expected, got, tolerance) ->
  assert.fail expected, got, "deviation too large", "=" if Math.abs(expected - got) > tolerance

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
    distance = gpx.distance2d a, b
    assert.fail distance, 75.5, "distance failure too large", "=" if Math.abs(75.5 - distance) > 0.01
    test.finish()
    
  'test distance in 3D': (test) ->
    a = new gpx.Point 10, 20, 10
    a_high = new gpx.Point 10, 20, 30
    b = new gpx.Point 15, 25, 10
    c = new gpx.Point 20, 30, 20
    # same point
    assert.equal 0, gpx.distance3d a, a
    # same point, different height
    assert.equal (a_high.ele - a.ele), gpx.distance3d a, a_high
    # different points, same height
    assert.equal (gpx.distance2d a, b), gpx.distance3d a, b
    # different points, different height
    distance = gpx.distance3d a, c
    # thx interwebz
    dist2d = gpx.distance2d a, c
    # thx pythagoras
    true_distance = Math.sqrt(dist2d*dist2d + (c.ele - a.ele) * (c.ele - a.ele))
    assert.fail distance, true_distance, "distance failure too large", "=" if Math.abs(true_distance - distance) > 0.01
    test.finish()
