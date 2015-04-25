/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Rahul Nadella https://github.com/rahulnadella
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "Preferences.h"

@implementation Preferences

NSString * const BEST_PHOTO_PAGE_IDENTIFIER = @"Best Photo Page";
NSString * const CANCEL = @"Cancel";
NSString * const CATEGORIES = @"Categories";
NSString * const CHECKINS_DESCENDING = @"Checkins (Descending)";
NSString * const CHECKED = @"checked";
NSString * const CLIENT_ID = @"client_id";
NSString * const CLIENT_SECRET = @"client_secret";
NSString * const RESTAURANT_KIT_IDENTIFIER = @"WUMOMXQOV1OJJW5EKAKL4GNV5J42IA5UFO4FOAHBSK4V5HZT";
NSString * const RESTAURANT_KIT_SECRET = @"D5EWTP3B10GHAC0T4FUHE4MSYE55LDVZQXGGXZSJDRHO5SLZ";
NSString * const CATEGORY_ID = @"categoryId";
NSString * const CATEGORY_NAME = @"categoryName";
NSString * const CLOSED_SIGN = @"closedSign";
NSString * const DISTANCE_ASCENDING = @"Distance (Ascending)";
NSString * const ERROR_DESCRIPTION = @"Unable to retrieve Venues for specific Category";
NSString * const ERROR_TITLE = @"ERROR: UNABLE TO RETRIEVE VENUES";
NSString * const FOURSQUARE_API = @"https://api.foursquare.com";
NSString * const ICON_EXTENSION_32 = @"%@bg_32%@";
NSString * const ICON_EXTENSION_64 = @"%@bg_64.png";
NSString * const LATITUDE_LONGITUDE = @"ll";
NSString * LATITUDE_LONGITUDE_FROM_LOCATION = @"";
NSString * const MAP_TYPE_TITLE = @"MAP VIEW TO BE DISPLAYED";
NSString * const MAP_TYPE_DESCRIPTION = @"Please Choose the Map View (Type) to be Displayed";
double const METERS_PER_MILE = 1609.344;
NSString * const NO_INTERNET_CONNECTION_AVAILABLE = @"NO INTERNET CONNECTION AVAILABLE";
NSString * const NO_INTERNET_CONNECTION_AVAILABLE_DESCRIPTION = @"You currently do not have access to an active internet connection";
NSString * const OKAY = @"Ok";
NSString * const OPEN_SIGN = @"openSign";
NSString * const PLIST = @"plist";
NSString * const PUBLIC = @"public";
NSString * const PREFIX = @"prefix";
NSString * const RESPONSE_VENUE = @"response.venue";
NSString * const RESPONSE_VENUES = @"response.venues";
NSString * const RETURN_TO_VENUE_INFORMATION = @"Return to Venue Information";
NSString * const SHOW_WEBPAGE_VIEW_IDENTIFIER = @"Show Web Page";
NSString * const SORT_DESCRIPTION = @"Sort Venue(s) by Distance or Checkins";
NSString * const SORT_TITLE = @"Sort Venue(s)";
NSString * const UNCHECKED = @"unchecked";
NSString * const VENUE_ID = @"VENUE_ID";
NSString * const VENUE_SEARCH = @"/v2/venues/search";
NSString * const VENUE_ID_SEARCH = @"v2/venues/";
NSString * const VERSION = @"v";
NSString * const VERSION_NUMBER = @"20140609";
NSString * const VENUE_DETAILS_VIEW_IDENTIFIER = @"Show Map View";
NSString * const VENUE_MAP_VIEW_IDENTIFIER = @"Show Venue Map View";

NSString * const STANDARD = @"Standard Map";
NSString * const HYBRID = @"Hybrid Map";
NSString * const SATELLITE = @"Satellite Map";
@end
