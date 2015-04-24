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

#import <Social/Social.h>
#import "VenueDetailsViewController.h"
#import "VenueMapViewController.h"
#import "WebPageViewController.h"

@interface VenueDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCheckins;
@property (weak, nonatomic) IBOutlet UILabel *tipsLeft;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIButton *urlButton;
@property (weak, nonatomic) IBOutlet UILabel *facebookLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tierLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@end

@implementation VenueDetailsViewController

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && [self.view window] == nil)
    {
        self.view = nil;
    }
    /* Dispose of any resources that can be recreated. */
    self.venueId = nil;
    self.nameOfVenue = nil;
    self.urlOfVenue = nil;
    self.menuOfUrlVenu = nil;
    self.facebookHandle = nil;
    self.twitterHandle = nil;
    self.currentContact = nil;
    self.currentLocation = nil;
    self.currentMenu = nil;
    self.currentStats = nil;
    self.locationNameLabel = nil;
    self.streetAddressLabel = nil;
    self.cityStateZipcodeLabel = nil;
    self.totalCheckins = nil;
    self.tipsLeft = nil;
    self.phoneLabel = nil;
    self.twitterLabel = nil;
    self.twitterButton = nil;
    self.urlLabel = nil;
    self.urlButton = nil;
    self.facebookLabel = nil;
    self.facebookButton = nil;
    self.menuLabel = nil;
    self.menuButton = nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Retrieve the UIBarButton objects */
    NSMutableArray *rightButtons = [self initializeRightNavigationButtons];
    /* Set the specific method to call when clicked */
    UIBarButtonItem *map = [rightButtons objectAtIndex:0];
    map.action = @selector(retrieveMapView);
    /* Set the UIBarButton objects to the right side of the view */
    self.navigationItem.rightBarButtonItems = rightButtons;
    
    /* Retrieve the Left UIBarButtonItems and Initialize the left header of VenueDetailsView */
    NSMutableArray *leftButtons = [self initializeLeftNavigationButtons];
    self.navigationItem.leftBarButtonItems = leftButtons;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /* Initialize ViewDetailsViewController content */
    [self initializeViewContent];
}

#pragma mark - Initialize View Content

- (void)initializeViewContent
{
    /* Define the name of the View based on the specific Venue */
    self.locationNameLabel.text = [NSString stringWithFormat:@"Contact Info (%@)", self.verifiedStatus];
    
    /* Create the street address of the specific Venue */
    self.streetAddressLabel.text = self.currentLocation.crossStreet ? [NSString stringWithFormat:@"%@ (%@)", self.currentLocation.address, self.currentLocation.crossStreet] : [NSString stringWithFormat:@"%@", self.currentLocation.address] ;
    
    /* Create the city, state, zip code of the specific Venue */
    self.cityStateZipcodeLabel.text = [NSString stringWithFormat:@"%@, %@ %@", self.currentLocation.city, self.currentLocation.state, self.currentLocation.postalCode];
    
    /* Initialize the total number of visits to specific Venue */
    self.totalCheckins.text = [NSString stringWithFormat:@"%@ %@", @"Total Checkins: ", self.currentStats.checkins];
    
    /* Initialize the tips left at specific Venue */
    self.tipsLeft.text = self.currentStats.tips ? [NSString stringWithFormat:@"%@ %@", @"Tips Left: ", self.currentStats.tips] : @"Tips Left: 0";
    
    /* Retrieve the contact info (phone number, twitter handle, etc) for specific Venue */
    self.phoneLabel.text = self.currentContact.formattedPhone ? [NSString stringWithFormat:@"Contact Number: %@", self.currentContact.formattedPhone] : @"Contact Number: N/A";
    self.twitterLabel.text = @"Twitter:";
    
    /* Store the Venue Twitter handle */
    self.twitterHandle = self.currentContact.twitter ? [NSString stringWithFormat:@"@%@", self.currentContact.twitter] : @"N/A";
    [self.twitterButton setTitle:self.twitterHandle forState:UIControlStateNormal];
    
    /* Retrieve the url address of the specific Venue (if Available) */
    self.urlLabel.text = @"Web Address:";
    [self.urlButton setTitle:self.urlOfVenue forState:UIControlStateNormal];
    
    /* Store the Venue Facebook handle */
    self.facebookLabel.text = @"Facebook:";
    self.facebookHandle = self.currentContact.facebookName ? [NSString stringWithFormat:@"@%@", self.currentContact.facebookName] : @"N/A";
    [self.facebookButton setTitle:self.facebookHandle forState:UIControlStateNormal];
    
    /* Store the Menu url address of the specifc Venue (if Available) */
    self.menuLabel.text = @"Menu:";
    self.menuOfUrlVenu = self.currentMenu.mobileUrl ? [NSString stringWithFormat:@"%@", self.currentMenu.mobileUrl] : @"N/A";
    [self.menuButton setTitle:self.menuOfUrlVenu forState:UIControlStateNormal];
    
    /* Set the rating of the specific Venue */
    self.ratingLabel.text = self.rating ? [NSString stringWithFormat:@"Rating: %.01f", [self.rating floatValue]] : @"Current Rating: N/A";
    
    self.tierLabel.text = self.currentPrice ? [NSString stringWithFormat:@"Tier Level: %@", self.currentPrice.tier] : @"Tier Level: N/A";
    self.messageLabel.text = self.currentPrice ? [NSString stringWithFormat:@"Expense Level: %@", self.currentPrice.costLevel] : @"Expense Level: N/A";
    self.currencyLabel.text = self.currentPrice ? [NSString stringWithFormat:@"Currency: %@", self.currentPrice.currency] : @"Currency: N/A";
}

#pragma mark - Swipe Back

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction & UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Active Web Address

- (IBAction)activeWebAddress:(id)sender
{
    if (self.urlOfVenue)
    {
        [self performSegueWithIdentifier:@"Show Web Page" sender:self];
    }
}

#pragma mark - Facebook

- (IBAction)sendFacebookMessage:(id)sender
{
    if (self.facebookHandle)
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebookSheet setInitialText:self.facebookHandle];
            [self presentViewController:facebookSheet animated:YES completion:nil];
        }
    }
}

#pragma mark - Twitter

- (IBAction)tweet:(id)sender
{
    if (self.twitterHandle)
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:self.twitterHandle];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
    }
}

#pragma mark - Venue Webpage MapView Action

- (void)retrieveMapView
{
    if (self.currentLocation)
    {
        [self showAlertSheetBySegueIdentifier:VENUE_DETAILS_VIEW_IDENTIFIER];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Web Page"])
    {
        if ([segue.destinationViewController isKindOfClass:[WebPageViewController class]])
        {
            WebPageViewController *wpvc = segue.destinationViewController;
            [wpvc setUrlAddress:self.urlOfVenue];
            [wpvc setCurrentLocation:self.currentLocation];
            [wpvc setNameOfVenue:self.nameOfVenue];
        }
    }
    else if ([segue.identifier isEqualToString:@"Show Menu"])
    {
        if ([segue.destinationViewController isKindOfClass:[WebPageViewController class]])
        {
            WebPageViewController *wpvc = segue.destinationViewController;
            [wpvc setMenuAddress:self.menuOfUrlVenu];
            [wpvc setCurrentLocation:self.currentLocation];
            [wpvc setNameOfVenue:self.nameOfVenue];
        }
    }
    else if ([segue.identifier isEqualToString:VENUE_DETAILS_VIEW_IDENTIFIER])
    {
        if ([segue.destinationViewController isKindOfClass:[VenueMapViewController class]])
        {
            VenueMapViewController *vmvc = segue.destinationViewController;
            [vmvc setCurrentLatitude:self.currentLocation.lat];
            [vmvc setCurrentLongitude:self.currentLocation.lng];
            [vmvc setTitleOfVenue:self.nameOfVenue];
            [vmvc setIsMultipleVenues:true];
            [vmvc setMenuType:self.mapType];
            /* Set View Controller Title */
            [vmvc setTitle:@"Restaurant Location"];
        }
    }
}

@end
