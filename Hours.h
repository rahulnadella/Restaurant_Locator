//
//  Hours.h
//  RestaurantKit
//
//  Created by Rahul Nadella on 4/24/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeFrame.h"

@interface Hours : NSObject

@property (nonatomic) BOOL isOpen;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *timeframes;

@end
