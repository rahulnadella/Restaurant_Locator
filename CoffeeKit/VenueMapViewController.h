//
//  VenueMapViewController.h
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/5/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueMapViewController : UIViewController

@property (nonatomic, strong) NSNumber *currentLatitude;
@property (nonatomic, strong) NSNumber *currentLongitude;
@property (nonatomic, strong) NSString *titleOfVenue;

@end
