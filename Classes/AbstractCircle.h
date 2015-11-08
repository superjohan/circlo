//
//  AbstractCircle.h
//  Circlo
//
//  Created by Johan Halin on 6/7/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractCircle : UIView

@property (nonatomic) CGPoint savedCenter;
@property (nonatomic) CGRect savedFrame;
@property (nonatomic) UIColor *color;

// for manual animation
@property (nonatomic) CGPoint destinationPoint;
@property (nonatomic) NSTimeInterval animationDuration;

- (void)animateToPoint:(CGPoint)point withDuration:(NSTimeInterval)duration;
- (void)moveCircleWithDelta:(NSTimeInterval)delta;

@end
