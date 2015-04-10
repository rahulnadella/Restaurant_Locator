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
#import "Appearance.h"
#import "CoffeeKitAppDelegate.h"

@implementation CoffeeKitAppDelegate

#pragma AppDelegate methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DEBUG
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
#endif
    /* Change the font, color and style of the Application */
    [Appearance customizeNavigationAppearance];
    
    [self initLocation];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if ([CLLocationManager significantLocationChangeMonitoringAvailable])
    {
        /* Stop normal location updates and start significant location change updates for battery efficiency. */
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Significant location change monitoring is not available." message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:OKAY style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:ok];
        
        id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        if([rootViewController isKindOfClass:[UINavigationController class]])
        {
            rootViewController=[((UINavigationController *)rootViewController).viewControllers objectAtIndex:0];
        }
        [rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.locationManager stopMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    [self returnLocationData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Initialization Location

- (void)initLocation
{
    if ([CLLocationManager locationServicesEnabled])
    {
        /* Create the CLLocationManager object */
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
            [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            [self.locationManager requestWhenInUseAuthorization];
        }
        else
        {
            [self.locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    
    NSDate* eventDate = self.currentLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              self.currentLocation.coordinate.latitude,
              self.currentLocation.coordinate.longitude);
        [self returnLocationData];
    }

    [self returnLocationData];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"User still thinking...");
        }   break;
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"User did not accept");
        }   break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            [self.locationManager startUpdatingLocation];
        }   break;
        default:
            break;
    }
}

# pragma mark - Retrieving the change Location Data

- (void)returnLocationData
{
    LATITUDE_LONGITUDE_FROM_LOCATION = [NSString stringWithFormat:@"%+.6f,%+.6f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
}

@end
