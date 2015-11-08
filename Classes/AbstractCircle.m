//
//  AbstractCircle.m
//  Circlo
//
//  Created by Johan Halin on 6/7/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "AbstractCircle.h"

@interface AbstractCircle ()
@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic) BOOL animating;
@property (nonatomic) CGPoint startPoint;
@end

@implementation AbstractCircle

- (void)animateToPoint:(CGPoint)point withDuration:(NSTimeInterval)duration
{
	self.destinationPoint = point;
	self.animationDuration = duration;
	self.currentTime = 0;
	self.animating = YES;
	self.startPoint = self.center;
}

- (void)moveCircleWithDelta:(NSTimeInterval)delta
{
	if (self.animating == NO)
	{
		return;
	}
	
	self.currentTime += delta;
	
	CGFloat deltaX = (self.startPoint.x - self.destinationPoint.x) * (self.currentTime / self.animationDuration);
	CGFloat deltaY = (self.startPoint.y - self.destinationPoint.y) * (self.currentTime / self.animationDuration);
	
	if (self.currentTime >= self.animationDuration)
	{
		self.center = self.destinationPoint;
		self.animating = NO;
		return;
	}
	
	self.center = CGPointMake(self.startPoint.x - deltaX, self.startPoint.y - deltaY);
}

@end
