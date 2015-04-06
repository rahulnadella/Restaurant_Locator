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

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "Location.h"
#import "Menu.h"
#import "Stats.h"
/*
 The VenueDetailsViewController provides specific details associated with each Venue. For example, the Contact info, the number of people visted, etc.
 
 @version 1.0
 */
@interface VenueDetailsViewController : UIViewController

@property (nonatomic, strong) NSString *nameOfVenue;
@property (nonatomic, strong) NSString *urlOfVenue;
@property (nonatomic, strong) NSString *twitterHandle;
@property (nonatomic, strong) NSString *facebookHandle;
@property (nonatomic, strong) NSString *menuOfUrlVenu;
@property (nonatomic, strong) Contact *currentContact;
@property (nonatomic, strong) Location *currentLocation;
@property (nonatomic, strong) Menu *currentMenu;
@property (nonatomic, strong) Stats *currentStats;

@end
