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
 */
@interface Preferences : NSObject

extern NSString * const CATEGORIES;
extern NSString * const CLIENT_ID;
extern NSString * const CLIENT_SECRET;
extern NSString * const COFFEE_KIT_IDENTIFIER;
/* This value should always be retrieved from a server (this only for demo purposes) */
extern NSString * const COFFEE_KIT_SECRET;
extern NSString * const CATEGORY_ID;
extern NSString * const CATEGORY_NAME;
extern NSString * const FOURSQUARE_API;
extern NSString * const LATITUDE_LONGITUDE;
extern NSString * const PLIST;
extern NSString * const RESPONSE_VENUE;
extern NSString * const RETURN_TO_VENUE_INFORMATION;
extern NSString * const VENUE_SEARCH;
extern NSString * const VERSION;
extern NSString * const VERSION_NUMBER;

@end
