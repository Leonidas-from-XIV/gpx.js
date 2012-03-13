(function() {
  var R, jsdom, to_rad,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jsdom = require('jsdom');

  R = 6371;

  to_rad = function(angle) {
    return angle * Math.PI / 180;
  };

  exports.GPX = (function() {

    function GPX() {
      this.parseString = __bind(this.parseString, this);
      void 0;
    }

    GPX.prototype.parseString = function(xml, cb) {
      return jsdom.env(xml.toString(), function(err, window) {
        var ele, elevation, item, lat, lon, result, trkpts, _i, _len;
        trkpts = window.document.getElementsByTagName('trkpt');
        result = [];
        for (_i = 0, _len = trkpts.length; _i < _len; _i++) {
          item = trkpts[_i];
          lon = parseFloat(item.getAttribute('lon'));
          lat = parseFloat(item.getAttribute('lat'));
          elevation = item.getElementsByTagName('ele')[0];
          ele = parseFloat(elevation.firstChild.nodeValue);
          result.push({
            lat: lat,
            lon: lon,
            ele: ele
          });
        }
        return cb(void 0, result);
      });
    };

    return GPX;

  })();

  exports.Point = (function() {

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
