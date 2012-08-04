//
//  LayoutManager.h
//  Circlo
//
//  Created by Johan Halin on 5/8/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReactiveCircleView;

@interface LayoutManager : NSObject

+ (void)createClockLayoutInView:(UIView *)view;
+ (void)createUnanimatedCircleLayoutInView:(UIView *)view;
+ (void)createMenuViewLayoutInView:(UIView *)view;

@end
