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

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) IBOutlet CircloViewController *viewController;

@end

