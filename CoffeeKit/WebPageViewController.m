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
#import "WebPageViewController.h"
#import "VenueMapViewController.h"

@interface WebPageViewController () <UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebPageViewController

#pragma mark - Properties

@synthesize menuAddress = _menuAddress;
@synthesize urlAddress = _urlAddress;

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    /* Dispose of any resources that can be recreated. */
    self.currentLocation = nil;
    self.menuAddress = nil;
    self.nameOfVenue = nil;
    self.urlAddress = nil;
    self.webView = nil;
    self.activityIndicator = nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationItem setTitle:@"Restaurant Webpage"];
    
    /* Retrieve the UIBarButton objects */
    NSMutableArray *buttons = [self retrieveRightNavigationButtons];
    /* Set the specific method to call when clicked */
    UIBarButtonItem *map = [buttons objectAtIndex:0];
    map.action = @selector(retrieveMapViewFromWebpage);
    /* Set the UIBarButton objects to the right side of the view */
    self.navigationItem.rightBarButtonItems = buttons;
    
    /* Retrieve the UIBarButtonItems and Initialize the left header of WebpageView */
    NSMutableArray *leftButtons = [self initializeLeftBarButtons];
    self.navigationItem.leftBarButtonItems = leftButtons;
    
    [self refresh:self];
}

#pragma mark - Swipe Back

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction & UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Back

- (IBAction)back:(UIButton *)sender
{
    [self.webView goBack];
}

#pragma mark - Forward

- (IBAction)forward:(UIButton *)sender
{
    [self.webView goForward];
}

#pragma mark - Refresh

- (IBAction)refresh:(id)sender
{
    self.webView.delegate = self;
    /* Determine which address is active */
    NSString *activeAddress = self.urlAddress ? self.urlAddress : self.menuAddress;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:activeAddress]]];
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertController *connectionView = [UIAlertController alertControllerWithTitle:NO_INTERNET_CONNECTION_AVAILABLE message:NO_INTERNET_CONNECTION_AVAILABLE_DESCRIPTION preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *previous = [UIAlertAction actionWithTitle:RETURN_TO_VENUE_INFORMATION style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [connectionView addAction:previous];
    [self presentViewController:connectionView animated:YES completion:nil];
}

#pragma mark - Venue Webpage MapView Action

- (void)retrieveMapViewFromWebpage
{
    if (self.currentLocation)
    {
        [self showAlertSheetBySegueIdentifier:VENUE_MAP_VIEW_IDENTIFIER];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:VENUE_MAP_VIEW_IDENTIFIER])
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
