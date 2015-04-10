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

#import <Foundation/Foundation.h>
/*
 The Preferences object holds global and/or constant values associated with CoffeeKit application
 
 @version 1.0
 */
@interface Preferences : NSObject

extern NSString * const CANCEL;
extern NSString * const CATEGORIES;
extern NSString * const CHECKINS_DESCENDING;
extern NSString * const CLIENT_ID;
extern NSString * const CLIENT_SECRET;
extern NSString * const COFFEE_KIT_IDENTIFIER;
/* This value should always be retrieved from a server (this only for demo purposes) */
extern NSString * const COFFEE_KIT_SECRET;
extern NSString * const CATEGORY_ID;
extern NSString * const CATEGORY_NAME;
extern NSString * const DISTANCE_ASCENDING;
extern NSString * const ERROR_DESCRIPTION;
extern NSString * const ERROR_TITLE;
extern NSString * const FOURSQUARE_API;
extern NSString * const ICON_EXTENSION_32;
extern NSString * const ICON_EXTENSION_64;
extern NSString * const LATITUDE_LONGITUDE;
extern NSString * LATITUDE_LONGITUDE_FROM_LOCATION;
extern NSString * const MAP_TYPE_TITLE;
extern NSString * const MAP_TYPE_DESCRIPTION;
extern double const METERS_PER_MILE;
extern NSString * const NO_INTERNET_CONNECTION_AVAILABLE;
extern NSString * const NO_INTERNET_CONNECTION_AVAILABLE_DESCRIPTION;
extern NSString * const OKAY;
extern NSString * const PLIST;
extern NSString * const PREFIX;
extern NSString * const RESPONSE_VENUE;
extern NSString * const RESPONSE_VENUES;
extern NSString * const RETURN_TO_VENUE_INFORMATION;
extern NSString * const SORT_DESCRIPTION;
extern NSString * const SORT_TITLE;
extern NSString * const VENUE_ID;
extern NSString * const VENUE_SEARCH;
extern NSString * const VENUE_ID_SEARCH;
extern NSString * const VERSION;
extern NSString * const VERSION_NUMBER;
extern NSString * const VENUE_DETAILS_VIEW_IDENTIFIER;
extern NSString * const VENUE_MAP_VIEW_IDENTIFIER;
/* MapStyle Constraints */
extern NSString * const STANDARD;
extern NSString * const HYBRID;
extern NSString * const SATELLITE;

@end
