(function() {
  var R, to_rad;

  R = 6371;

  to_rad = function(angle) {
    return angle * Math.PI / 180;
  };

  exports.GPX = (function() {

    function GPX(string) {
      void 0;
    }

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

}).call(this);
