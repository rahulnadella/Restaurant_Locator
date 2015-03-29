//
//  MasterViewController.m
//  CoffeeKit
//
//  Created by Scott McAlister on 1/21/14.
//  Copyright (c) 2014 4 Arrows Media, LLC. All rights reserved.
//

#import "MasterViewController.h"
#import "Venue.h"
#import "VenueCell.h"
#import <RestKit/RestKit.h>

#define kCLIENTID "WUMOMXQOV1OJJW5EKAKL4GNV5J42IA5UFO4FOAHBSK4V5HZT"
#define kCLIENTSECRET "D5EWTP3B10GHAC0T4FUHE4MSYE55LDVZQXGGXZSJDRHO5SLZ"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureRestKit];
    [self loadVenues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipsCount": @"tips", @"usersCount": @"users"}];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];


    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search" keyPath:@"response.venues" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];

}

- (void)loadVenues
{
    NSString *latLon = @"37.33,-122.03"; // approximate latLon of The Mothership
    NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", @"4bf58dd8d48988d1e0931735", @"categoryId", @"20140118", @"v", nil];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        _venues = mappingResult.array;
        [self.tableView reloadData];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"What do you mean by 'there is no coffee?': %@", error);
    }];
}

@end
