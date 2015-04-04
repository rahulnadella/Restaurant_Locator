//
//  Menu.h
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/4/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *mobileUrl;

@end
