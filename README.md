# CoffeeITTest
Takehome assignment CoffeeIT (time spent: aprox 4 hours)

Ran into some issues trying to installing MapBox through Carthage, likely due to some version incompatibility between XCode version, Carthage version and/or Mapbox. Decided to move forward using MKMapView instead.

Since I already lost quite some time troubleshooting carthage and the API data  I did not implement a weather API.

For this I would probably use the DarkSky API which takes a lat/long and gives a JSON with weather information. I would feed the annotation coordinates through this to obtain the weather data for the selected location. 
