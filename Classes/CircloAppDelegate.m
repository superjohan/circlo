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

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Private

- (void)_createUserDefaults
{
	if(![[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsAppHasLaunchedBefore])
	{
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCircloUserDefaultsAppHasLaunchedBefore];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCircloUserDefaultsSoundEnabled];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	[self _createUserDefaults];
	
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	[self.viewController stopAllCircleAnimations];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
	[self.viewController startAllCircleAnimations];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
