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

#import <Foundation/Foundation.h>
/*
The Appearance object defines the various fonts (UIFont), color shading (NSShadow), 
 default color (UIColor) and overall appearance.
 
 @version 1.0
 */
@interface Appearance : NSObject
/* 
 The customizeNavigationAppearance method specifies the appearance of the UINavigation menu.
 
 @version 1.0
 */
+ (void)customizeNavigationAppearance;

/*
 The customizeNavigationBarColor method specifies the color of the UINavigationBar menu.
 
 @version 1.0
 */
+ (void)customizeNavigationBarColor;

/*
 Converts the hex value of a Color to a UIColor object
 
 @version 1.0
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/*
 The underlineLabel method underlines any NSAttributedString present in the UIView
 
 @version 1.0
 */
+ (NSMutableAttributedString *)underlineLabel:(NSAttributedString *)textLabel;

@end
