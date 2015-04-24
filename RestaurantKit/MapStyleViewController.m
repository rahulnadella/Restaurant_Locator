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
#import "Appearance.h"

/* BOOL to String converter for verified Venue */
static inline NSString* NSStringFromBOOL(BOOL aBool)
{
    return aBool? @"Business Owner Verified Information" : @"Information NOT Verified";
}

@implementation MapStyleViewController

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && [self.view window] == nil)
    {
        self.view = nil;
    }
    /* Dispose of any resources that can be recreated. */
    self.mapType = nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Need to set the values of the Venue retrieved via Foursquare */
    [self retrieveVenue];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /* Set the color (if available) for the view based on the rating */
    self.ratingColor ? [self.view setBackgroundColor:[Appearance colorWithHexString:self.ratingColor]] : nil;
}

#pragma mark - Initialize the UIBarButtonItems (Right Side)

- (NSMutableArray *)initializeRightNavigationButtons
{
    /* Initialize an Array of size equal to 1 */
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    /* Add UIBarButtonItem MAP */
    UIImage *map = [[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:map
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:nil];
    [buttons addObject:mapButton];
    
    /* Add UIBarButtonItem STATUS - Open or Closed */
    UIBarButtonItem *statusButton = [[UIBarButtonItem alloc] initWithImage:nil
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:nil];
    if (self.hours.isOpen)
    {
        /* Open sign */
        UIImage *statusOpen = [[UIImage imageNamed:OPEN_SIGN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [statusButton setImage:statusOpen];
    }
    else
    {
        /* Closed Sign */
        UIImage *statusClosed = [[UIImage imageNamed:CLOSED_SIGN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [statusButton setImage:statusClosed];
    }
    [buttons addObject:statusButton];
    
    return buttons;
}

#pragma mark - Initialize the UIBarButtonItems (Left Side)

- (NSMutableArray *)initializeLeftNavigationButtons
{
    /* Initialize an Array of size equal to 2 */
    NSMutableArray *leftButtons = [[NSMutableArray alloc] initWithCapacity:1];
    
    /* Add UIBarButtonItem BACK */
    UIImage *back = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /* Add UIImage to the UIBarButtonItem */
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:back
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(previousViewController)];
    [leftButtons addObject:backButton];
    
    return leftButtons;
}

# pragma mark - Previous ViewController

- (void)previousViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Show AlertSheet

- (void)showAlertSheetBySegueIdentifier:(NSString *)identifier
{
    /* Using the UIAlertController in iOS 8.0 (ActionSheetDelegate is deprecated) */
    UIAlertController *mapView = [UIAlertController alertControllerWithTitle:MAP_TYPE_TITLE
                                                                      message:MAP_TYPE_DESCRIPTION
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    /* Create the Distance Ascending action */
    UIAlertAction *standard = [UIAlertAction actionWithTitle:STANDARD
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
        [self setMapType:STANDARD];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    /* Create the Checkins Descending action */
    UIAlertAction *hybrid = [UIAlertAction actionWithTitle:HYBRID
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *alert){
        [self setMapType:HYBRID];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    UIAlertAction *satellite = [UIAlertAction actionWithTitle:SATELLITE
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
        [self setMapType:SATELLITE];
        [self performSegueWithIdentifier:identifier sender:self];
    }];
    
    /* Create the Cancel Button */
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    /* Add the Distance, Checkins, and Cancel to the View */
    [mapView addAction:standard];
    [mapView addAction:hybrid];
    [mapView addAction:satellite];
    [mapView addAction:cancel];
    /* Present the Alert to the present View */
    [self presentViewController:mapView animated:YES completion:nil];
}

# pragma mark - Retrieve and Process Venue data

- (void)retrieveVenue
{
    /* Generate the specific RESTful API call using the Foursquare API */
    NSString *venueIdSearch = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",
                               FOURSQUARE_API, @"/", VENUE_ID_SEARCH, self.venueId, @"?", CLIENT_ID, @"=",
                               RESTAURANT_KIT_IDENTIFIER, @"&", CLIENT_SECRET, @"=", RESTAURANT_KIT_SECRET,
                               @"&", VERSION, @"=", VERSION_NUMBER];

    /* Open the URL to obtain the JSON Data from Foursquare */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueIdSearch]];
    /* Perform request and get JSON back as a NSData object */
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    /* Process the JSON data for specific Venue */
    [self processVenueRequest:response];
}

- (void)processVenueRequest:(NSData *)response
{
    NSError *localError = nil;
    /* Parse the JSON data for the Specific Venue's item(s) */
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&localError];
    NSArray *results = [data valueForKey:@"response"];
    NSDictionary *venue = [results valueForKey:@"venue"];
    
    /* Current price level of the Venue */
    NSDictionary *price = [venue valueForKey:@"price"];
    self.currentPrice = [[Price alloc] init];
    self.currentPrice.costLevel = [price valueForKey:@"message"];
    self.currentPrice.currency = [price valueForKey:@"currency"];
    self.currentPrice.tier = [price valueForKey:@"tier"];
    
    /* Determine if the Venue has been verified or not */
    self.verified = [venue valueForKey:@"verified"];
    self.verifiedStatus = NSStringFromBOOL(self.verified);
    
    /* Obtain the rating for a specific Venue */
    self.rating = [venue valueForKey:@"rating"];
    self.ratingColor = [venue valueForKey:@"ratingColor"];
    
    /* Retrieve the Time the Venue is open for */
    NSDictionary *hours = [venue objectForKey:@"hours"];
    self.hours = [[Hours alloc] init];
    self.hours.isOpen = [hours valueForKey:@"isOpen"];
    self.hours.status = [hours valueForKey:@"status"];
    self.hours.timeframes = [hours valueForKey:@"timeframes"];
    
    /* Retrieve the best Photo from the specific Venue */
    NSDictionary *bestPhoto = [venue objectForKey:@"bestPhoto"];
    self.bestPhoto = [[Photo alloc] init];
    self.bestPhoto.photoId = [bestPhoto valueForKey:@"id"];
    self.bestPhoto.prefix = [bestPhoto valueForKey:@"prefix"];
    self.bestPhoto.suffix = [bestPhoto valueForKey:@"suffix"];
    self.bestPhoto.width = [bestPhoto valueForKey:@"width"];
    self.bestPhoto.height = [bestPhoto valueForKey:@"height"];
    self.bestPhoto.visibility = [bestPhoto valueForKey:@"visibility"];
}

@end
