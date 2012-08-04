//
//  AbstractCircle.m
//  Circlo
//
//  Created by Johan Halin on 6/7/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "AbstractCircle.h"

@interface AbstractCircle ()
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) CGPoint startPoint;
@end

@implementation AbstractCircle

@synthesize savedCenter;
@synthesize savedFrame;
@synthesize color;

@synthesize destinationPoint;
@synthesize animationDuration;
@synthesize currentTime;
@synthesize animating;
@synthesize startPoint;

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
	if(!animating)
		return;
	
	self.currentTime += delta;
	
	CGFloat deltaX = (self.startPoint.x - self.destinationPoint.x) * (self.currentTime / self.animationDuration);
	CGFloat deltaY = (self.startPoint.y - self.destinationPoint.y) * (self.currentTime / self.animationDuration);
	
	if(self.currentTime >= self.animationDuration)
	{
		self.center = self.destinationPoint;
		self.animating = NO;
		return;
	}
	
	self.center = CGPointMake(self.startPoint.x - deltaX, self.startPoint.y - deltaY);
}

- (void)dealloc
{
	self.color = nil;
	
	[super dealloc];
}

@end
