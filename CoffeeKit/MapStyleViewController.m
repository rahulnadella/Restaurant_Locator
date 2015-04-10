/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Rahul Nadella https://github.com/rahulnadella
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "MapStyleViewController.h"

@implementation MapStyleViewController

@synthesize mapType = _mapType;

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    /* Dispose of any resources that can be recreated. */
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
