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

#import "Appearance.h"

@implementation Appearance

#pragma mark - Customize Navigation Appearance

+ (void)customizeNavigationAppearance
{
    /* Create resizable images */
    UIImage *gradientImage44 = [[UIImage imageNamed:@"surf_gradient_textured_44"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44
                                       forBarMetrics:UIBarMetricsDefault];
    
    /* Create the desired color */
    UIColor *color = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    /* Create the Shadow Color and Offset */
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset: CGSizeMake(0.0f, -1.0f)];
    /* Create the desired FONT for the Navigation Bar */
    UIFont *font = [UIFont fontWithName:@"Cochin-BoldItalic" size:20.0];
    /* Map of attributes to define look of Navigation Bar */
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:1];
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    [attributes setObject:shadow forKey:NSShadowAttributeName];
    [attributes setObject:font forKey:NSFontAttributeName];
    
    /* Customize the title text for *all* UINavigationBars */
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}

#pragma mark - Customize NavigationBar Color

+ (void)customizeNavigationBarColor
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

@end
