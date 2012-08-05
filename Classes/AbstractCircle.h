//
//  AbstractCircle.h
//  Circlo
//
//  Created by Johan Halin on 6/7/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractCircle : UIView

@property (nonatomic, assign) CGPoint savedCenter;
@property (nonatomic, assign) CGRect savedFrame;
@property (nonatomic, strong) UIColor *color;

// for manual animation
@property (nonatomic, assign) CGPoint destinationPoint;
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)animateToPoint:(CGPoint)point withDuration:(NSTimeInterval)duration;
- (void)moveCircleWithDelta:(NSTimeInterval)delta;

@end
