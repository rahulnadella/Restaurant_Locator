//
//  VenueMapViewController.m
//  CoffeeKit
//
//  Created by Rahul Nadella on 4/5/15.
//  Copyright (c) 2015 Rahul Nadella. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VenueMapViewController.h"

@interface VenueMapViewController()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

#define METERS_PER_MILE 1609.344

@implementation VenueMapViewController

@synthesize currentLatitude = _currentLatitude;
@synthesize currentLongitude = _currentLongitude;
@synthesize titleOfVenue = _titleOfVenue;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.currentLatitude floatValue];
    zoomLocation.longitude = [self.currentLongitude floatValue];
    
    CLLocationDistance visibleDistance = METERS_PER_MILE;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, visibleDistance, visibleDistance);
    
    [self.mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = zoomLocation;
    pointAnnotation.title = self.titleOfVenue;
    [self.mapView addAnnotation:pointAnnotation];
}


@end
