//
//  Photo.h
//  RestaurantKit
//
//  Created by Rahul Nadella on 4/24/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *visibility;

@end
