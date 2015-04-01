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

@end

@implementation VenueDetailsViewController

#pragma mark - Properties

@synthesize nameOfVenue = _nameOfVenue;
@synthesize urlOfVenue = _urlOfVenue;
@synthesize twitterHandle = _twitterHandle;
@synthesize currentContact = _currentContact;
@synthesize currentLocation = _currentLocation;
@synthesize currentStats = _currentStats;

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    /* Define the name of the View based on the specific Venue */
    self.locationNameLabel.text = @"Contact Info";
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
    self.twitterHandle = self.currentContact.twitter ? [NSString stringWithFormat:@"@%@", self.currentContact.twitter] : nil;
    [self.twitterButton setTitle:self.twitterHandle forState:UIControlStateNormal];
    /* Retrieve the url address of the specific Venue (if Available) */
    self.urlLabel.text = @"Web Address:";
    [self.urlButton setTitle:self.urlOfVenue forState:UIControlStateNormal];
}

#pragma mark - Active Web Address

- (IBAction)activeWebAddress:(id)sender
{
    if (self.urlOfVenue)
    {
        [self performSegueWithIdentifier:@"Show Web Page" sender:self];
    }
}

#pragma mark - Tweet

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

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Web Page"])
    {
        if ([segue.destinationViewController isKindOfClass:[WebPageViewController class]])
        {
            WebPageViewController *wpvc = segue.destinationViewController;
            [wpvc setUrlAddress:self.urlOfVenue];
        }
    }
}


@end
