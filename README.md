# CoffeeITTest
Takehome assignment CoffeeIT (time spent: aprox 4 hours)

Ran into some issues trying to installing MapBox thourh Carthage, likely due to some version incompatibility between XCode version, Carthage version and/or Mapbox. Decided to move forward using MKMapView instead.


I could not retrieve the data from the API. Instead I obtained a list like this: 

2020-01-18 11:51:02.219931+0100 CoffeeIT[2933:233068] Metal API Validation Enabled
2020-01-18 11:51:02.293006+0100 CoffeeIT[2933:233068] libMobileGestalt MobileGestalt.c:1647: Could not retrieve region info
2020-01-18 11:51:02.459744+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
2020-01-18 11:51:02.475549+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
2020-01-18 11:51:02.477419+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
2020-01-18 11:51:02.479309+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
2020-01-18 11:51:02.481156+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
2020-01-18 11:51:02.483034+0100 CoffeeIT[2933:233188] [Renderer] IconRenderer: HorizontalStretchPadding (18.000000, 18.000000) is larger than the image size (34.000000, 54.000000). Image will now use the center column of pixels to stretch.
...


After that I used a stub to show how I would approach showing the annotations on the map, and by clicking one show the preview. 

Since I already lost quite some time troubleshooting carthage and the API data and because I have more take-home assignment to complete I did not implement a weather API.

For this I would probably use the DarkSky API which takes a lat/long and gives a JSON with weather information. I would feed the annotation coordinates through this to obtain the weather data for the selected location. 
