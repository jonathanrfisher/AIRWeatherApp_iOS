//
//  AIRAppDelegate.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRAppDelegate.h"

@implementation AIRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.jpg"]]];
    NSLog(@"Whether you like the weather or whether you do not, at least you aren't a wether.  Google it.");
    
    return YES;
}

@end
