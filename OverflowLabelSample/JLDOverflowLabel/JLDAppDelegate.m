//
//  JLDAppDelegate.m
//  JLDOverflowLabel
//
//  Created by Jean-Luc Dagon on 10/05/13.
//  Copyright (c) 2013 Cocoapps. All rights reserved.
//

#import "JLDAppDelegate.h"

#import "JLDViewController.h"

@implementation JLDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[JLDViewController alloc] initWithNibName:@"JLDViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
