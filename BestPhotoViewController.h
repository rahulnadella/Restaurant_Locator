//
//  BestPhotoViewController.h
//  RestaurantKit
//
//  Created by Rahul Nadella on 4/24/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface BestPhotoViewController : UIViewController

@property (nonatomic, strong) NSString *bestPhotoTitle;
@property (nonatomic, strong) Photo *bestPhoto;

@end
