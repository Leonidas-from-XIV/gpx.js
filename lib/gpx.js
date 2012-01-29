(function() {

  exports.GPX = (function() {

    function GPX(string) {
      void 0;
    }

    return GPX;

  })();

  exports.Point = (function() {

    function Point(lon, lat, ele) {
      this.lon = lon;
      this.lat = lat;
      this.ele = ele;
    }

    return Point;

  })();

  exports.distance2d = function(a, b) {
    var lon_diff;
    return lon_diff = Math.abs(a.lon - b.lon);
  };

}).call(this);
