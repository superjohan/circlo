//
//  LayoutManager.m
//  Circlo
//
//  Created by Johan Halin on 5/8/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "LayoutManager.h"
#import "PulseCircleView.h"
#import "ReactiveCircleView.h"
#import "Circle.h"
#import "MenuView.h"
#import "ColorScheme.h"
#import "ColorSchemeManager.h"
#import "SoundManager.h"

@implementation LayoutManager

+ (void)createClockLayoutInView:(UIView *)view
{
	CGFloat iPhoneCircleSize = 56.0;
	CGFloat iPadCircleSize = 130.0;
	CGFloat circleSize = 0;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		circleSize = iPadCircleSize;
	else
		circleSize = iPhoneCircleSize;
	
	CGFloat xPadding = (view.bounds.size.width - (5 * circleSize)) / 2.0;
	CGFloat yPadding = (view.bounds.size.height - (6 * circleSize)) / 2.0;
	CGFloat amplitude = (circleSize / iPhoneCircleSize) * 10;
	
	NSInteger tagCounter = 1;
	
	double freq = 3.0;
	NSMutableArray *frequencies = [NSMutableArray array];
	for (NSInteger i = 0; i < 30; i++)
	{
		[frequencies addObject:@(freq)];
		freq += .075;
	}
	
	for (NSInteger i = 0; i < 6; i++)
	{
		for (NSInteger j = 0; j < 5; j++)
		{
			NSString *text = nil;
			CGRect circleFrame = CGRectMake(xPadding + (j * circleSize),
											yPadding + (i * circleSize),
											circleSize,
											circleSize);
			
			PulseCircleView *circ = [[PulseCircleView alloc] initWithFrame:circleFrame title:text button:NO];
			circ.amplitude = amplitude;
			
			NSInteger frequencyIndex = arc4random() % frequencies.count;
			circ.frequency = [[frequencies objectAtIndex:frequencyIndex] doubleValue];
			[frequencies removeObjectAtIndex:frequencyIndex];

			circ.tag = tagCounter;
			circ.userInteractionEnabled = NO;
			[view addSubview:circ];
			
			[circ hide];
			
			if (tagCounter > 0 && tagCounter < 13)
			{
				circ.soundType = kSoundTypeHours;
				circ.soundNumber = tagCounter;
			}
			else if (tagCounter >= 13 && tagCounter < 15)
			{
				circ.soundType = kSoundTypeAMPM;
				circ.soundNumber = tagCounter - 12;
			}
			else if (tagCounter >= 15 && tagCounter < 21)
			{
				circ.soundType = kSoundTypeMinutesLeft;
				circ.soundNumber = tagCounter - 14;
			}
			else if (tagCounter >= 21 && tagCounter < 31)
			{
				circ.soundType = kSoundTypeMinutesRight;
				circ.soundNumber = tagCounter - 20;
			}
			
			tagCounter = tagCounter + 1;
		}
	}
}


+ (void)createUnanimatedCircleLayoutInView:(UIView *)view
{
	CGFloat iPhoneCircleSize = 32.0;
	CGFloat iPadCircleSize = 130.0; // FIXME
	CGFloat circleSize = 0;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		circleSize = iPadCircleSize;
	else
		circleSize = iPhoneCircleSize;
	
	for (NSInteger i = 0; i < 10; i++)
	{
		for (NSInteger j = 0; j < 15; j++)
		{
			CGRect circleFrame = CGRectMake(i * circleSize, j * circleSize, circleSize, circleSize);
			Circle *circle = [[Circle alloc] initWithFrame:circleFrame];
			circle.userInteractionEnabled = NO;
			[view addSubview:circle];
		}
	}
}


+ (void)createMenuViewLayoutInView:(UIView *)view
{
	UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
	overlayButton.frame = view.bounds;
	overlayButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	overlayButton.tag = kOverlayButtonTag;
	[view addSubview:overlayButton];
	
	CGRect backgroundCircleFrame = CGRectMake(0, view.bounds.size.height - floor(view.bounds.size.width / 2.0), view.bounds.size.width, view.bounds.size.width);
	PulseCircleView *backgroundCircle = [[PulseCircleView alloc] initWithFrame:backgroundCircleFrame title:nil button:NO];
	backgroundCircle.tag = kBackgroundCircleTag;
	[view addSubview:backgroundCircle];
	
	CGFloat length = floor(view.bounds.size.width / 6.4);
	CGFloat xPadding = floor(view.bounds.size.width / (32.0 / 6.0));
	CGFloat xOrigin = floor((view.bounds.size.width - ((4 * xPadding) + length)) / 2.0);
	CGFloat yOrigin = view.bounds.size.height - xPadding;
	
	CGRect circle1Frame = CGRectMake(xOrigin, yOrigin, length, length);
	PulseCircleView *circle1 = [[PulseCircleView alloc] initWithFrame:circle1Frame title:NSLocalizedString(@"One", nil) button:YES];
	circle1.tag = kColorCircle1Tag;
	[view addSubview:circle1];
	
	CGRect circle2Frame = CGRectMake(circle1Frame.origin.x + xPadding, yOrigin, length, length);
	PulseCircleView *circle2 = [[PulseCircleView alloc] initWithFrame:circle2Frame title:NSLocalizedString(@"Two", nil) button:YES];
	circle2.tag = kColorCircle2Tag;
	[view addSubview:circle2];

	CGRect circle3Frame = CGRectMake(circle2Frame.origin.x + xPadding, yOrigin, length, length);
	PulseCircleView *circle3 = [[PulseCircleView alloc] initWithFrame:circle3Frame title:NSLocalizedString(@"Three", nil) button:YES];
	circle3.tag = kColorCircle3Tag;
	[view addSubview:circle3];
	
	CGRect circle4Frame = CGRectMake(circle3Frame.origin.x + xPadding, yOrigin, length, length);
	PulseCircleView *circle4 = [[PulseCircleView alloc] initWithFrame:circle4Frame title:NSLocalizedString(@"Four", nil) button:YES];
	circle4.tag = kColorCircle4Tag;
	[view addSubview:circle4];
	
	CGRect circle5Frame = CGRectMake(circle4Frame.origin.x + xPadding, yOrigin, length, length);
	PulseCircleView *circle5 = [[PulseCircleView alloc] initWithFrame:circle5Frame title:NSLocalizedString(@"Five", nil) button:YES];
	circle5.tag = kColorCircle5Tag;
	[view addSubview:circle5];
	
	CGFloat soundCircleLength = floor(view.bounds.size.width / 4.0);
	CGRect soundCircleFrame = CGRectMake(floor((view.bounds.size.width / 2.0) - (soundCircleLength / 2.0)), 
										 floor(backgroundCircleFrame.origin.y + (view.bounds.size.width * 0.03125)), 
										 soundCircleLength, 
										 soundCircleLength);
	PulseCircleView *soundCircle = [[PulseCircleView alloc] initWithFrame:soundCircleFrame title:NSLocalizedString(@"Sound", nil) button:YES];
	soundCircle.tag = kSoundCircleTag;
	[view addSubview:soundCircle];
}




@end
