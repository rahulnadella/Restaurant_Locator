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

#import "VenueViewController.h"
#import <RestKit/RestKit.h>
#import "VenueCell.h"
#import "VenueDetailsViewController.h"
#import "VenueMapViewController.h"

@interface VenueViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation VenueViewController

#pragma mark - Properties

@synthesize currentVenue = _currentVenue;
@synthesize currentCategoryId = _currentCategoryId;

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - awakeFromNib

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Available Restaurants"];
    /* Initialize an Array of size equal to 2 */
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    /* Add UIBarButtonItem SORT */
    UIImage *sort = [[UIImage imageNamed:@"sort"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /* Add UIImage to the UIBarButtonItem */
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithImage:sort style:UIBarButtonItemStylePlain target:self action:@selector(showAlertSheet)];
    [buttons addObject:sortButton];
    
    UIImage *map = [[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:map style:UIBarButtonItemStylePlain target:self action:@selector(showMapView)];
    [buttons addObject:mapButton];
    
    self.navigationItem.rightBarButtonItems = buttons;
    
    /* Configure RestKit to connect to Foursquare API */
    [self configureRestKit];
    /* Retrieve the venues specified by the mapping */
    [self loadVenues];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    Venue *venue = _venues[indexPath.row];
    cell.nameLabel.text = venue.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", venue.location.distance.floatValue];
    cell.checkinsLabel.text = [NSString stringWithFormat:@"%d checkins", venue.stats.checkins.intValue];
    
    /* Retrieve the icon from the categories array */
    NSDictionary *icon = [[venue.categories objectAtIndex:0] icon];
    NSString *prefix = [icon objectForKey:@"prefix"];
    NSString *suffix = [icon objectForKey:@"suffix"];
    
    /* Create the desired path based on the prefix and suffix of the specific Category */
    NSString *imageUrl = [NSString stringWithFormat:@"%@bg_32%@", prefix, suffix];
    /* Retrieve the Category image */
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    cell.venueCategoryImage.image = [UIImage imageWithData:imageData];
    
    /* Set the image based on the if there are any people at the Venue */
    cell.statusImage.image = (venue.hereNow.count.intValue > 0) ? [UIImage imageNamed:@"openSign"] : [UIImage imageNamed:@"closedSign"];
    
    return cell;
}

#pragma mark - Ascending Order by Distancer

- (void)ascendingOrderByDistance
{
    _venues = [self.venues sortedArrayUsingComparator: ^(id a, id b) {
        NSNumber *firstDistance = [[(Venue *)a location] distance];
        NSNumber *secondDistance = [[(Venue *)b location] distance];
        return [firstDistance compare:secondDistance];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Descending Order by Checkins

- (void)descendingOrderByCheckins
{
    _venues = [self.venues sortedArrayUsingComparator:^(id a, id b){
        NSNumber *firstCheckIns = [[(Venue *)a stats] checkins];
        NSNumber *secondCheckIns = [[(Venue *)b stats] checkins];
        return [secondCheckIns compare:firstCheckIns];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Show AlertSheet

- (void)showAlertSheet
{
    /* Using the UIAlertController in iOS 8.0 (ActionSheetDelegate is deprecated) */
    UIAlertController *sortView = [UIAlertController alertControllerWithTitle:SORT_TITLE
                                                                      message:SORT_DESCRIPTION
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    /* Create the Distance Ascending action */
    UIAlertAction *distance = [UIAlertAction actionWithTitle:DISTANCE_ASCENDING style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self ascendingOrderByDistance];
    }];
    /* Create the Checkins Descending action */
    UIAlertAction *checkins = [UIAlertAction actionWithTitle:CHECKINS_DESCENDING style:UIAlertActionStyleDefault handler:^(UIAlertAction *alert){
        [self descendingOrderByCheckins];
    }];
    /* Create the Cancel Button */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    /* Add the Distance, Checkins, and Cancel to the View */
    [sortView addAction:distance];
    [sortView addAction:checkins];
    [sortView addAction:cancel];
    [self presentViewController:sortView animated:YES completion:nil];
}

#pragma mark - Show AlertView

- (void)showAlertView
{
    /* Use UIAlertController to create the Alert (UIAlertView is deprecated in iOS 8.0) */
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:ERROR_TITLE message:ERROR_DESCRIPTION preferredStyle:UIAlertControllerStyleAlert];
    /* Add the OK Alert */
    UIAlertAction *ok = [UIAlertAction actionWithTitle:OKAY style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        exit(0);
    }];
    /* Add the CANCEL Alert */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    /* Add the OK and CANCEL to the View */
    [errorAlert addAction:ok];
    [errorAlert addAction:cancel];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

#pragma mark - Show MapView

- (void)showMapView
{
    if (self.venues)
    {
        [self performSegueWithIdentifier:@"Show Venues Map View" sender:self];
    }
}

#pragma mark - Configure RestKit

- (void)configureRestKit
{
    /* Initialize AFNetworking HTTPClient */
    NSURL *baseURL = [NSURL URLWithString:FOURSQUARE_API];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    /* Initialize RestKit */
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    /* Setup Object Mappings */
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"id", @"name", @"url"]];
    
    /* Define the Contact Object Mapping */
    RKObjectMapping *contactMapping = [RKObjectMapping mappingForClass:[Contact class]];
    [contactMapping addAttributeMappingsFromArray:@[@"phone", @"formattedPhone", @"twitter", @"facebook", @"facebookUsername", @"facebookName"]];
    
    /* Define Location Object Mapping */
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    /* Define Stats Object Mapping */
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipCount": @"tips", @"usersCount": @"users"}];
    
    /* Define Categories Object Model */
    RKObjectMapping *venueCategoryMapping = [RKObjectMapping mappingForClass:[Categories class]];
    [venueCategoryMapping addAttributeMappingsFromArray:@[@"id", @"name", @"icon", @"primary"]];
    
    /* Define HereNow Object Model */
    RKObjectMapping *statusMapping = [RKObjectMapping mappingForClass:[HereNow class]];
    [statusMapping addAttributeMappingsFromArray:@[@"count"]];
    
    RKObjectMapping *menuMapping = [RKObjectMapping mappingForClass:[Menu class]];
    [menuMapping addAttributeMappingsFromArray:@[@"type", @"label", @"url", @"mobileUrl"]];
    
    /* Define Relationship Mapping - Contact, Location, Stats */
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"contact" toKeyPath:@"contact" withMapping:contactMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"categories" toKeyPath:@"categories" withMapping:venueCategoryMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hereNow" toKeyPath:@"hereNow" withMapping:statusMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menu" toKeyPath:@"menu" withMapping:menuMapping]];

    /* Register mappings with the provider using a response descriptor */
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:VENUE_SEARCH keyPath:RESPONSE_VENUES statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

#pragma mark - Load Venues

- (void)loadVenues
{
    NSString *latLon = LATITUDE_LONGITUDE_FROM_LOCATION; // @"37.33,-122.03" AKA Apple;
    NSString *clientID = COFFEE_KIT_IDENTIFIER;
    NSString *clientSecret = COFFEE_KIT_SECRET;
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, LATITUDE_LONGITUDE, clientID, CLIENT_ID, clientSecret, CLIENT_SECRET, self.currentCategoryId, CATEGORY_ID, VERSION_NUMBER, VERSION, nil];
    /* Retrieve the venues from Foursquare using predefined settings */
    [[RKObjectManager sharedManager] getObjectsAtPath:VENUE_SEARCH parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        _venues = mappingResult.array;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        /* Alert the user that an error occured while retrieving the Venue(s) */
        [self showAlertView];
    }];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Retrieve the current Venue being selected by the user */
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Venue *currentVenue = _venues[indexPath.row];
    self.currentVenue = currentVenue;
    
    if ([segue.identifier isEqualToString:@"Show Current Venue"])
    {
        if ([segue.destinationViewController isKindOfClass:[VenueDetailsViewController class]])
        {
            VenueDetailsViewController *vdvc = segue.destinationViewController;
            if (self.currentVenue)
            {
                [vdvc setTitle:self.currentVenue.name];
                [vdvc setVenueId:self.currentVenue.id];
                [vdvc setNameOfVenue:self.currentVenue.name];
                [vdvc setUrlOfVenue:self.currentVenue.url];
                [vdvc setCurrentLocation:self.currentVenue.location];
                [vdvc setCurrentStats:self.currentVenue.stats];
                [vdvc setCurrentContact:self.currentVenue.contact];
                [vdvc setCurrentMenu:self.currentVenue.menu];
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"Show Venues Map View"])
    {
        if ([segue.destinationViewController isKindOfClass:[VenueMapViewController class]])
        {
            VenueMapViewController *vmvc = segue.destinationViewController;
            [vmvc setIsMultipleVenues:false];
            NSMutableArray *businesses = (NSMutableArray *)self.venues;
            [vmvc setBusinesses:businesses];
            [vmvc setCurrentLatitude:self.currentVenue.location.lat];
            [vmvc setCurrentLongitude:self.currentVenue.location.lng];
            /* Set View Controller Title */
            [vmvc setTitle:@"Restaurant(s) Location"];
        }
    }
}

#pragma mark - Swipe Back

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction & UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
