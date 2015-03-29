//
//  DetailViewController.h
//  CoffeeKit
//
//  Created by Rahul Nadella on 3/29/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

