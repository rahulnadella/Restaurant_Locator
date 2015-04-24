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

#import "BestPhotoViewController.h"

@interface BestPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bestPhotoImageView;

@end

@implementation BestPhotoViewController

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
    // Do any additional setup after loading the view.
    
    /* View Title */
    NSString *bestPhotoViewTitle = [NSString stringWithFormat:@"%@ %@", self.bestPhotoTitle, @"Best Photo"];
    /* Setting Navigation Title */
    [self.navigationItem setTitle:bestPhotoViewTitle];
    
    /* Parse the image from Foursquare API */
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@x%@%@",
                          self.bestPhoto.prefix,
                          self.bestPhoto.width,
                          self.bestPhoto.height,
                          self.bestPhoto.suffix];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    /* Instantiate the image from Foursquare */
    self.bestPhotoImageView.image = [UIImage imageWithData:imageData];
}

@end
