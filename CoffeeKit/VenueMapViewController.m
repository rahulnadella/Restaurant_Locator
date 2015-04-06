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

#import "VenueMapViewController.h"
#import "Venue.h"

@interface VenueMapViewController() <MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *annotations;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VenueMapViewController

#pragma mark - Properties

@synthesize businesses = _businesses;
@synthesize currentLatitude = _currentLatitude;
@synthesize currentLongitude = _currentLongitude;
@synthesize isMultipleVenues = _isMultipleVenues;
@synthesize titleOfVenue = _titleOfVenue;

- (NSMutableArray *)annotations
{
    if (!_annotations)
    {
        _annotations = [[NSMutableArray alloc] init];
    }
    return _annotations;
}

- (NSMutableArray *)businesses
{
    if (!_businesses)
    {
        _businesses = [[NSMutableArray alloc] init];
    }
    return _businesses;
}

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /* Set the delegate for MKMapView */
    self.mapView.delegate = self;
    
    /* Check to see if the user is viewing a single or multiple Venue(s) */
    self.isMultipleVenues ? [self initializeSingleVenue] : [self initializeMultipleVenues];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* Start the ActivityIndicator */
    self.activityIndicator.hidden = FALSE;
    [self.activityIndicator startAnimating];
}

# pragma mark - Create MKPointAnnotation

- (MKPointAnnotation *)createMapViewAnnotationWith:(NSNumber *)latitude
                                      andLongitude:(NSNumber *)longitude
                                      andVenueName:(NSString *)nameOfVenue
{
    /* Attach the specific Venue's Location to a pin on the view */
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    /* Create the Coordinate to attach the Pin on MapView */
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
    pointAnnotation.title = nameOfVenue;
    return pointAnnotation;
}

#pragma mark - Create MapRegion

- (MKCoordinateRegion)createMapRegionWith:(NSNumber *)latitude
                             andLongitude:(NSNumber *)longitude
                       andVisibleDistance:(CLLocationDistance)distance
{
    /* Create the Location of the current Venue */
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [latitude floatValue];
    zoomLocation.longitude = [longitude floatValue];
    
    /* Create the Region of the specific Venue's location specified */
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, distance, distance);
    return viewRegion;
}

#pragma mark - Initialization of a Single Venue

- (void)initializeSingleVenue
{
    /* Create the MKCoordinateRegion and add it to the MapView */
    MKCoordinateRegion viewRegion = [self createMapRegionWith:self.currentLatitude
                                                 andLongitude:self.currentLongitude
                                           andVisibleDistance:(METERS_PER_MILE * 0.5)];
    [self.mapView setRegion:viewRegion animated:YES];
    
    /* Create MKPointAnnotation and add it to the MapView */
    MKPointAnnotation *pointAnnotation = [self createMapViewAnnotationWith:self.currentLatitude
                                                              andLongitude:self.currentLongitude
                                                              andVenueName:self.titleOfVenue];
    [self.mapView addAnnotation:pointAnnotation];
}

#pragma mark - Initialization of Multiple Venues

- (void)initializeMultipleVenues
{
    /* Create the MKCoordinateRegion and add it to the MapView */
    MKCoordinateRegion viewRegion = [self createMapRegionWith:self.currentLatitude
                                                 andLongitude:self.currentLongitude
                                           andVisibleDistance:(METERS_PER_MILE * 15)];
    [self.mapView setRegion:viewRegion animated:YES];
    
    /* Iterate the Venue objects to add each specific Location (latitude and longitude) to the MapView */
    for (Venue *venue in self.businesses)
    {
        if (venue.location)
        {
            MKPointAnnotation *pointAnnotation = [self createMapViewAnnotationWith:venue.location.lat
                                                                      andLongitude:venue.location.lng
                                                                      andVenueName:venue.name];
            [self.annotations addObject:pointAnnotation];
        }
    }
    /* Add the List of MKPointAnnotations to the MapView */
    [self.mapView addAnnotations:self.annotations];
}

#pragma mark - MKMapView Delegate methods

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    /* Stop the ActivityIndicator when the MapView has loaded */
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = TRUE;
}


@end
