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

#import "CategoryTableViewController.h"
#import "CategoryCell.h"
#import "VenueViewController.h"

@interface CategoryTableViewController ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation CategoryTableViewController

#pragma mark - Properties

@synthesize categories = _categories;

- (NSArray *)categories
{
    if (_categories)
    {
        /* Path to the plist (in the application bundle) */
        NSString *path = [[NSBundle mainBundle] pathForResource:CATEGORIES ofType:PLIST];
        
        _categories = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _categories;
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

    [[self navigationItem] setTitle:@"Food Categories"];
    
    /* Path to the plist (in the application bundle) */
    NSString *path = [[NSBundle mainBundle] pathForResource:CATEGORIES ofType:PLIST];
    /* Allocate/Initialize the plist file */
    self.categories = [[NSArray alloc] initWithContentsOfFile:path];
    /* Self-Sizing UITableViewCell */
    self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average" cell height is
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self initLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Initialization Location

- (void)initLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else
    {
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    NSLog(@"lat%f - lon%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"User still thinking...");
        }   break;
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"User did not accept");
        }   break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            [self.locationManager startUpdatingLocation];
        }   break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    categoryCell.title.text = [[self.categories objectAtIndex:indexPath.row] valueForKey:CATEGORY_NAME];
    
    return categoryCell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *currentCategory = [self.categories objectAtIndex:indexPath.row];
    NSString *categoryId = [currentCategory objectForKey:CATEGORY_ID];
    
    if ([segue.identifier isEqualToString:@"Show Current Venues"])
    {
        if ([segue.destinationViewController isKindOfClass:[VenueViewController class]])
        {
            VenueViewController *vvc = segue.destinationViewController;
            vvc.currentCategoryId = categoryId;
        }
    }
}


@end
