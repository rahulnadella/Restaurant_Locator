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
#import <UIKit/UIKit.h>
/*
 The VenueMapViewController displays the map view of the specific Venue's location.
 
 @version 1.0
 */
@interface VenueMapViewController : UIViewController
/* A list of Venue objects */
@property (nonatomic, strong) NSMutableArray *businesses;
@property (nonatomic, strong) NSNumber *currentLatitude;
@property (nonatomic, strong) NSNumber *currentLongitude;
@property (nonatomic) BOOL isMultipleVenues;
@property (nonatomic, strong) NSString *titleOfVenue;
/* Outlet connecting the MKMapView to Storyboard View */
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/* 
 The createMapViewAnnotationWithLatitudeandLongitudeandVenueName method that will 
 create and return MKPointAnnotation object.
 
 @version 1.0
 */
- (MKPointAnnotation *)createMapViewAnnotationWith:(NSNumber *)latitude
                                      andLongitude:(NSNumber *)longitude
                                      andVenueName:(NSString *)nameOfVenue;

/*
 The createMapRegionWithLatitudeandLongitudeandVenueName method that will create 
 and return MKRegion.
 
 @version 1.0
 */
- (MKCoordinateRegion)createMapRegionWith:(NSNumber *)latitude
                             andLongitude:(NSNumber *)longitude
                       andVisibleDistance:(CLLocationDistance)distance;

/*
 The initializeSingleVenue method creates a Venue on the MapView with its specific 
 location designated on the map.
 
 @version 1.0
 */
- (void)initializeSingleVenue;

/*
 The initializeMultipleVenues method creates Venue(s) on the MapView with each of 
 their designated location coordinates display on the map.
 
 @version 1.0
 */
- (void)initializeMultipleVenues;


@end
