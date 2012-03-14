A parser for GPX files
======================


Beware, this is a rather early version and API is somehow still in a flux. We
try to be most "correct" rather than carrying baggage. Expect things to be more
stabilized once we start uploading releases to the NPM registry.


Ok, so what exactly is it?
--------------------------

The idea of GPX.js is to provide a friendly interface for working with GPX
files. GPX files are the standard exchange format that is used for many GPS
applications. Many tracks are recorded in GPX format.

For some reason, there was no easy to find and use GPX library that can be used
on client-side browsers and server-side code. Therefore, GPX.js was born.

The idea of GPX.js is to be used to analyze and visualize GPX tracks for
example using third-party libraries like
[Leaflet](http://leaflet.cloudmade.com/).


Roadmap
-------

  * Calculate speed calculation of the points
  * Display distance of track taken
  * Calculate average speed, also average moving speed
  * Analyze track for absolute and relative speed
  * Find fastest distance on track
  * Analyze the elevation gain and loss


License
-------

Apache License, Version 2.0. For easy contribution and legal security.
