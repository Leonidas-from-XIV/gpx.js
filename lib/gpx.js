// Generated by CoffeeScript 1.3.1
(function() {
  var R, cheerio, to_rad,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  cheerio = require('cheerio');

  R = 6371;

  to_rad = function(angle) {
    return angle * Math.PI / 180;
  };

  exports.GPX = (function() {

    GPX.name = 'GPX';

    function GPX() {
      this.parseString = __bind(this.parseString, this);

      void 0;

    }

    GPX.prototype.parseString = function(xml, cb) {
      var $, result, trkpts;
      $ = cheerio.load(xml.toString());
      result = [];
      trkpts = $('trkpt').each(function(i, item) {
        var ele, elevation, lat, lon;
        lon = parseFloat($(item).attr('lon'));
        lat = parseFloat($(item).attr('lat'));
        elevation = $(item).find('ele');
        ele = parseFloat($(elevation).text());
        return result.push({
          lat: lat,
          lon: lon,
          ele: ele
        });
      });
      return cb(void 0, result);
    };

    return GPX;

  })();

  exports.Point = (function() {

    Point.name = 'Point';

    function Point(lat, lon, ele) {
      this.lat = lat;
      this.lon = lon;
      this.ele = ele;
    }

    return Point;

  })();

  exports.distance2d = function(a, b) {
    var c, dLat, dLon, lat1, lat2;
    dLat = to_rad(b.lat - a.lat);
    dLon = to_rad(b.lon - a.lon);
    lat1 = to_rad(a.lat);
    lat2 = to_rad(b.lat);
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  };

  exports.distance3d = function(a, b) {
    var height, planar;
    planar = exports.distance2d(a, b);
    height = Math.abs(a.ele - b.ele);
    return Math.sqrt(Math.pow(planar, 2) + Math.pow(height, 2));
  };

}).call(this);
