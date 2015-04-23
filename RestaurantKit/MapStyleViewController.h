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
#import "Location.h"
/*
 The MapStyleViewController is an object that contains the logic for displaying 
 a specific style of MapView. 
 
 The MapStyleViewController is a class that should
 be used for as base implementation of MapView customizable constraints.
 
 @version 1.0
 */
@interface MapStyleViewController : UIViewController

@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *mapType;
@property (nonatomic, strong) NSString *nameOfVenue;
@property (nonatomic, strong) Location *currentLocation;
/* Specific value(s) of the Venue retrieved via Social Framework */
@property (nonatomic) BOOL isOpen;
/*
 The showAlertSheet displays the an action sheet to allow the user to choose what MapType to display.
 
 @version 1.0
 */
- (void)showAlertSheetBySegueIdentifier:(NSString *)identifier;
/*
 The initializeRightNavigationButtons method gets the default right UIBarButtonItems for any interface extending the base implementation
 */
- (NSMutableArray *)initializeRightNavigationButtons;
/*
 The initializeLeftNavigationButtons method gets the default left UIBarButtonItems for any interface extending the base implementation.
 */
- (NSMutableArray *)initializeLeftNavigationButtons;
/*
 The exploreVenue method obtains information specific to the Venue being displayed
 */
- (void)exploreVenue;
@end
