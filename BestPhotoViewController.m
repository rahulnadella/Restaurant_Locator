//
//  BestPhotoViewController.m
//  RestaurantKit
//
//  Created by Rahul Nadella on 4/24/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import "BestPhotoViewController.h"

@interface BestPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bestPhotoImageView;

@end

@implementation BestPhotoViewController

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* View Title */
    NSString *bestPhotoViewTitle = [NSString stringWithFormat:@"%@ %@", self.bestPhotoTitle, @"Best Photo"];
    /* Setting Navigation Title */
    [self.navigationItem setTitle:bestPhotoViewTitle];
    
    /* Parse the image from Foursquare API */
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@x%@%@",
                          self.bestPhoto.prefix,
                          self.bestPhoto.width,
                          self.bestPhoto.height,
                          self.bestPhoto.suffix];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    /* Instantiate the image from Foursquare */
    self.bestPhotoImageView.image = [UIImage imageWithData:imageData];
}

@end
