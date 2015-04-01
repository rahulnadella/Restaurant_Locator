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

#import <RestKit/RestKit.h>
#import "VenueCell.h"
#import "VenueViewController.h"
#import "VenueDetailsViewController.h"

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
    
    [[self navigationItem] setTitle:@"Available Venues"];
    
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
    
    return cell;
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
                [vdvc setUrlOfVenue:self.currentVenue.url];
                [vdvc setCurrentLocation:self.currentVenue.location];
                [vdvc setCurrentStats:self.currentVenue.stats];
                [vdvc setCurrentContact:self.currentVenue.contact];
            }
        }
    }
}

#pragma mark - Configure RestKit

- (void)configureRestKit
{
    /* Initialize AFNetworking HTTPClient */
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    /* Initialize RestKit */
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    /* Setup Object Mappings */
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name", @"url"]];
    
    /* Define the Contact Object Mapping */
    RKObjectMapping *contactMapping = [RKObjectMapping mappingForClass:[Contact class]];
    [contactMapping addAttributeMappingsFromArray:@[@"phone", @"formattedPhone", @"twitter"]];
    
    /* Define Location Object Mapping */
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    /* Define Stats Object Mapping */
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipCount": @"tips", @"usersCount": @"users"}];
    
    /* Define Relationship Mapping - Contact, Location, Stats */
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"contact" toKeyPath:@"contact" withMapping:contactMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];


    /* Register mappings with the provider using a response descriptor */
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search" keyPath:@"response.venues" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];

}

#pragma mark - Load Venues

- (void)loadVenues
{
    NSString *latLon = @"37.33,-122.03"; // approximate latLon of The Mothership
    NSString *clientID = COFFEE_KIT_IDENTIFIER;
    NSString *clientSecret = COFFEE_KIT_SECRET;
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", self.currentCategoryId, @"categoryId", @"20120609", @"v", nil];
    /* Retrieve the venues from Foursquare using predefined settings */
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        _venues = mappingResult.array;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"What do you mean by 'there is no coffee?': %@", error);
    }];
}

@end
