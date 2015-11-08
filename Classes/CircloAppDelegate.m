//
//  CircloAppDelegate.m
//  Circlo
//
//  Created by Johan Halin on 5/5/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "CircloAppDelegate.h"
#import "CircloViewController.h"
#import "CircloConstants.h"

@implementation CircloAppDelegate

#pragma mark - Private

- (void)_createUserDefaults
{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsAppHasLaunchedBefore] == NO)
	{
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCircloUserDefaultsAppHasLaunchedBefore];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCircloUserDefaultsSoundEnabled];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	[self _createUserDefaults];
	
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[self.viewController stopAllCircleAnimations];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	[self.viewController startAllCircleAnimations];
}

@end
