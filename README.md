# Restaurant Locator

The Restaurant Locator is a sample iOS application that allows the user to locate Restaurant(s) using the user's current location (based on their latitude and longitude). The Restaurant data has been requested through the [Foursquare API](https://developer.foursquare.com/). The [Restkit](https://github.com/RestKit/RestKit) project is used as the RESTful API to retrieve and parse the data acquired from Foursquare.

#####Version
>Version 1.0 - Design and Implementation of the Restaurant Locator

#####Build
>Master -> Only works on iOS 8.2 or greater <br/>
>Frameworks -> AFNetworking, ISO8601DateFormatterValueTransformer, RKValueTransformers, RestKit, SBJson, SOCKit, and
TransitionKit (obtained via CocoaPods)

#####User Interface

The Restaurant Locator is a simple interface built using Xcode 6. The iOS application interface contains the following screens: Launch Screen, Types of Restaurants, Restaurants (in your location), the Map of the Restaurant(s), and the choosen Restaurant's details.

<img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/LaunchScreen.png" alt="Launch Screen" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/CategoryScreen.png" alt="Types of Restaurants" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/Venues.png" alt="Restaurants" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/MapView.png" alt="Map of Restaurant(s)" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/VenueDetails.png" alt="Specific Restaurant" width="125" height="250" /> 

The following user interface screens deal with specific options available to the user per Restaurant (if the data is available through the Foursquare API). The screenshots below detail the following functionality: the specific Restaurant's webpage, the specific Restaurant's menu, Sorting the Restaurant(s) available by distance or checkins, the Map view options (standard, hybrid, or satellite), and a hybrid map view of the specific Restaurant.

<img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/Webpage.png" alt="Restaurant Webpage" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/Menu.png" alt="Restaurant Menu" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/Sort.png" alt="Sort" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/MapType.png" alt="Map Options" width="125" height="250" /> <img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/RestaurantMap.png" alt="Map of Specific Restaurant" width="125" height="250" />

The following is the Best Picture from a specific Venue.

<img src="https://github.com/rahulnadella/Restaurant_Locator/blob/master/screenshots/BestPicture.png" alt="Restaurant Webpage" width="125" height="250" />

##License

*MIT License* --> A short, permissive software license. Basically, you can do whatever you want as long as you include the original copyright and license notice in any copy of the software/source.  There are many variations of this license in use.
