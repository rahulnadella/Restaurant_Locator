//
//  MapStyleViewController.m
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/10/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import "MapStyleViewController.h"

@implementation MapStyleViewController

@synthesize mapType = _mapType;

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.mapType = nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Show AlertSheet

- (void)showAlertSheet:(NSString *)identifier
{
    /* Using the UIAlertController in iOS 8.0 (ActionSheetDelegate is deprecated) */
    UIAlertController *mapView = [UIAlertController alertControllerWithTitle:MAP_TYPE_TITLE
                                                                      message:MAP_TYPE_DESCRIPTION
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    /* Create the Distance Ascending action */
    UIAlertAction *standard = [UIAlertAction actionWithTitle:STANDARD style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self setMapType:STANDARD];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    /* Create the Checkins Descending action */
    UIAlertAction *hybrid = [UIAlertAction actionWithTitle:HYBRID style:UIAlertActionStyleDefault handler:^(UIAlertAction *alert){
        [self setMapType:HYBRID];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    UIAlertAction *satellite = [UIAlertAction actionWithTitle:SATELLITE style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self setMapType:SATELLITE];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    
    /* Create the Cancel Button */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    /* Add the Distance, Checkins, and Cancel to the View */
    [mapView addAction:standard];
    [mapView addAction:hybrid];
    [mapView addAction:satellite];
    [mapView addAction:cancel];
    [self presentViewController:mapView animated:YES completion:nil];
}

@end
