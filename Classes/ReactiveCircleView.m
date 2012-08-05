//
//  ReactiveCircleView.m
//  Circlo
//
//  Created by Johan Halin on 6/5/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "ReactiveCircleView.h"
#import "PulseCircleView.h"
#import <QuartzCore/QuartzCore.h>
#import "Circle.h"
#import "AbstractCircle.h"

@implementation ReactiveCircleView

#pragma mark Private

- (double)_distanceFromPoint:(CGPoint)originPoint toPoint:(CGPoint)destinationPoint
{
	double a = destinationPoint.x - originPoint.x;
	double b = destinationPoint.y - originPoint.y;
	double c = sqrt(pow(a, 2) + pow(b, 2));

	if(c == 0) 
		return 0.00001; // this is only to prevent a division by zero
	
	return c;
}

- (NSTimeInterval)_durationFromPoint:(CGPoint)originPoint toPoint:(CGPoint)destinationPoint
{
	//
	// this calculation is saved for posterity because it's pretty good but i like the current one better
	//
	//CGFloat maxDistance = self.frame.size.width / 2.0;
	//return 1.5 - ([self _distanceFromPoint:originPoint toPoint:destinationPoint] / maxDistance);

	return 1;	
}

- (void)_moveCircle:(AbstractCircle *)circle inReactionToPoint:(CGPoint)point
{
	CGFloat maxDistance = self.frame.size.width / 2.0;
	double distance = [self _distanceFromPoint:circle.savedCenter toPoint:point];
	double difference = maxDistance - distance > 0 ? maxDistance - distance : 0;
	double ratio = difference / distance;
	CGFloat x = circle.savedCenter.x + (circle.savedCenter.x - point.x) * ratio;
	CGFloat y = circle.savedCenter.y + (circle.savedCenter.y - point.y) * ratio;
	CGPoint newPoint = CGPointMake(x, y);

	if(fabs(newPoint.x - circle.center.x) < 0.000001 && fabs(newPoint.y - circle.center.y) < 0.000001)
		return;
	
	circle.center = newPoint;

	if(![circle isKindOfClass:[PulseCircleView class]])
	{
		CGFloat sizeRatio = (distance / maxDistance) < 1 ? (distance / maxDistance) : 1;

		circle.frame = CGRectMake(circle.frame.origin.x, circle.frame.origin.y, circle.savedFrame.size.width * sizeRatio, circle.savedFrame.size.height * sizeRatio);
	}
}

- (void)_returnCircleToNormal:(AbstractCircle *)circle
{
	if(fabs(circle.savedCenter.x - circle.center.x) < 0.000001 && fabs(circle.savedCenter.y - circle.center.y) < 0.000001)
		return;
	
	circle.center = circle.savedCenter;

	if(![circle isKindOfClass:[PulseCircleView class]])
		circle.frame = CGRectMake(circle.savedFrame.origin.x, circle.savedFrame.origin.y, circle.savedFrame.size.width, circle.savedFrame.size.height);
}

- (void)_moveCirclesInReactionToPoint:(CGPoint)point
{
	UIViewAnimationOptions opts = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut;
	NSTimeInterval duration = 1;
	
	__weak ReactiveCircleView *bself = self;
	
	[UIView animateWithDuration:duration delay:0 options:opts animations:^{
		for(id view in [bself subviews])
		{
			if([view isKindOfClass:[PulseCircleView class]] || [view isKindOfClass:[Circle class]])
			{
				PulseCircleView *circle = view;
				
				[bself _moveCircle:circle inReactionToPoint:point];
			}
		}
	} completion:^(BOOL finished) {
	}];
}

- (void)_returnCirclesToNormal
{
	UIViewAnimationOptions opts = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut;
	NSTimeInterval duration = 1;
	
	__weak ReactiveCircleView *bself = self;
	
	[UIView animateWithDuration:duration delay:0 options:opts animations:^{
		for(id view in [bself subviews])
		{
			if([view isKindOfClass:[PulseCircleView class]] || [view isKindOfClass:[Circle class]])
			{
				PulseCircleView *circle = view;
				
				[bself _returnCircleToNormal:circle];
			}
		}	
	} completion:^(BOOL finished) {
	}];
}

- (void)_timerFired:(CADisplayLink *)sender
{
	for(id view in [self subviews])
	{
		if([view isKindOfClass:[PulseCircleView class]] || [view isKindOfClass:[Circle class]])
		{
			AbstractCircle *circle = view;
			
			[circle moveCircleWithDelta:sender.duration];
		}
	}
}

#pragma mark Public

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.exclusiveTouch = YES;
		self.userInteractionEnabled = YES;
    }
	
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint point = [[touches anyObject] locationInView:self];

	[self _moveCirclesInReactionToPoint:point];
	
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint point = [[touches anyObject] locationInView:self];
	
	[self _moveCirclesInReactionToPoint:point];
	
	[super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self _returnCirclesToNormal];
	
	[super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self _returnCirclesToNormal];
	
	[super touchesCancelled:touches withEvent:event];
}

- (void)startDisplayTimer
{
	CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_timerFired:)];
	[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
