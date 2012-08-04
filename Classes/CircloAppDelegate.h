//
//  CircloAppDelegate.h
//  Circlo
//
//  Created by Johan Halin on 5/5/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircloViewController;

@interface CircloAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    CircloViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CircloViewController *viewController;

@end

