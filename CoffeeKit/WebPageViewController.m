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

#import "WebPageViewController.h"

@interface WebPageViewController () <UIAlertViewDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebPageViewController

#pragma mark - Properties

@synthesize urlAddress = _urlAddress;

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

    [[self navigationItem] setTitle:@"Venue Webpage"];
    
    [self refresh:self];
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
    UIAlertView *noInternetConnectionAlert = [[UIAlertView alloc] initWithTitle:@"NO INTERNET CONNECTION AVAILABLE" message:@"You currently do not have access to an active internet connection" delegate:self cancelButtonTitle:RETURN_TO_VENUE_INFORMATION otherButtonTitles:nil, nil];
    [noInternetConnectionAlert show];
}

#pragma mark - AlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:RETURN_TO_VENUE_INFORMATION])
    {
        [self.navigationController popViewControllerAnimated:YES];
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
