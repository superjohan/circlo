//
//  Circle.m
//  Circlo
//
//  Created by Johan Halin on 6/7/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "Circle.h"

@implementation Circle

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
		self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = NO;
		self.savedCenter = self.center;
		self.savedFrame = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, self.color.CGColor);
	CGContextFillEllipseInRect(context, CGRectMake(1, 1, self.bounds.size.width - 2, self.bounds.size.height - 2));
}

@end
