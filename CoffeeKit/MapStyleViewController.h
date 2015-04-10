//
//  MapStyleViewController.h
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/10/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapStyleViewController : UIViewController

@property (nonatomic, strong) NSString *mapType;

- (void)showAlertSheet:(NSString *)identifier;

@end
