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

#import <MapKit/MapKit.h>
#import "VenueMapViewController.h"

@interface VenueMapViewController() <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VenueMapViewController

#pragma mark - Properties

@synthesize currentLatitude = _currentLatitude;
@synthesize currentLongitude = _currentLongitude;
@synthesize titleOfVenue = _titleOfVenue;

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
    /* Hide the ActivityIndicator when VenueMapView is loaded */
    self.activityIndicator.hidden = TRUE;
    
    [self.navigationItem setTitle:@"Venue Map View"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /* Set the delegate for MKMapView */
    self.mapView.delegate = self;
    /* Create the Location of the current Venue */
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.currentLatitude floatValue];
    zoomLocation.longitude = [self.currentLongitude floatValue];
    
    /* Define the distance visible by the user */
    CLLocationDistance visibleDistance = METERS_PER_MILE;
    
    /* Create the Region of the specific Venue's location specified */
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, visibleDistance, visibleDistance);
    [self.mapView setRegion:viewRegion animated:YES];
    
    /* Attach the specific Venue's Location to a pin on the view */
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = zoomLocation;
    pointAnnotation.title = self.titleOfVenue;
    [self.mapView addAnnotation:pointAnnotation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* Start the ActivityIndicator */
    self.activityIndicator.hidden = FALSE;
    [self.activityIndicator startAnimating];
}

#pragma mark - MKMapView Delegate methods

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    /* Stop the ActivityIndicator when the MapView has loaded */
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = TRUE;
}


@end
