gpx = require '../lib/gpx'
assert = require 'assert'
fs = require 'fs'
path = require 'path'

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
    assertSimilar distance, 75.5, 0.01
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
    dist2d = gpx.distance2d a, c
    # thx pythagoras
    true_distance = Math.sqrt(dist2d*dist2d + (c.ele - a.ele) * (c.ele - a.ele))
    assertSimilar distance, true_distance, 0.01
    test.finish()
    
  'parse GPX': (test) ->
    fileName = path.join __dirname, '/fixtures/simple.gpx'
    fs.readFile fileName, (err, data)  ->
      parser = new gpx.GPX
      e = [
        new gpx.Point(35.14662, 136.96714, 84),
        new gpx.Point(35.14665, 136.9671, 84),
        new gpx.Point(35.14669, 136.96706, 83.7),
        new gpx.Point(35.14672, 136.967, 83.2),
        new gpx.Point(35.14675, 136.96694, 83.7)
      ]
      parser.parseString data, (err, results) ->
        for i in [0...e.length]
          assert.deepEqual results[i], e[i]
        test.finish()
  
