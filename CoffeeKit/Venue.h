//
//  Venue.h
//  CoffeeKit
//
//  Created by Scott McAlister on 1/21/14.
//  Copyright (c) 2014 4 Arrows Media, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Stats.h"

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Stats *stats;

@end
