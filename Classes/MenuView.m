//
//  MenuView.m
//  Circlo
//
//  Created by Johan Halin on 6/22/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "MenuView.h"
#import "PulseCircleView.h"
#import "LayoutManager.h"
#import "ColorSchemeManager.h"
#import "SoundManager.h"

@interface MenuView ()
@property (nonatomic) PulseCircleView *colorCircle1;
@property (nonatomic) PulseCircleView *colorCircle2;
@property (nonatomic) PulseCircleView *colorCircle3;
@property (nonatomic) PulseCircleView *colorCircle4;
@property (nonatomic) PulseCircleView *colorCircle5;
@property (nonatomic) PulseCircleView *soundCircle;
@property (nonatomic) UIButton *overlayButton;
@property (nonatomic) PulseCircleView *backgroundCircle;
@end

@implementation MenuView

#pragma mark - Private

- (void)_overlayButtonTouched:(id)sender
{
	if ([self.delegate respondsToSelector:@selector(overlayButtonTouchedInMenuView:)])
	{
		[self.delegate overlayButtonTouchedInMenuView:self];
	}
}

- (void)_setSoundSelection
{
	self.soundCircle.selected = [SoundManager soundOn];
}

- (void)_setColorScheme:(ColorScheme *)scheme
{
	self.backgroundCircle.color = scheme.primaryColor;
	self.colorCircle1.color = scheme.secondaryColor;
	self.colorCircle1.textColor = scheme.primaryColor;
	self.colorCircle2.color = self.colorCircle1.color;
	self.colorCircle2.textColor = self.colorCircle1.textColor;
	self.colorCircle3.color = self.colorCircle1.color;
	self.colorCircle3.textColor = self.colorCircle1.textColor;
	self.colorCircle4.color = self.colorCircle1.color;
	self.colorCircle4.textColor = self.colorCircle1.textColor;
	self.colorCircle5.color = self.colorCircle1.color;
	self.colorCircle5.textColor = self.colorCircle1.textColor;
	self.soundCircle.color = self.colorCircle1.color;
	self.soundCircle.textColor = self.colorCircle1.textColor;
	
	for (NSInteger i = 1; i < kSoundCircleTag; i++)
	{
		PulseCircleView *circle = (PulseCircleView *)[self viewWithTag:i];
		
		if (i == scheme.colorSchemeType)
		{
			circle.selected = YES;
		}
		else
		{
			circle.selected = NO;
		}
	}
	
	[self _setSoundSelection];
}

#pragma mark - PulseCircleViewDelegate

- (void)touchUpInCircleView:(PulseCircleView *)circleView
{
	if (circleView.tag > 0 && circleView.tag < 6)
	{
		if ([self.delegate respondsToSelector:@selector(menuView:changedToColorScheme:)])
		{
			[self _setColorScheme:[self.delegate menuView:self changedToColorScheme:circleView.tag]];
		}
	}
	
	if (circleView.tag == kSoundCircleTag)
	{
		[SoundManager toggleSound];
		[self _setSoundSelection];
	}
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame colorScheme:(ColorScheme *)scheme
{
    if ((self = [super initWithFrame:frame]))
	{
		[LayoutManager createMenuViewLayoutInView:self];
		
		self.overlayButton = (UIButton *)[self viewWithTag:kOverlayButtonTag];
		[self.overlayButton addTarget:self action:@selector(_overlayButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
		
		self.backgroundCircle = (PulseCircleView *)[self viewWithTag:kBackgroundCircleTag];
		self.backgroundCircle.frequency = 10;
		self.backgroundCircle.amplitude = 10;
		
		self.colorCircle1 = (PulseCircleView *)[self viewWithTag:kColorCircle1Tag];
		self.colorCircle1.frequency = 4;
		self.colorCircle1.delegate = self;
		
		self.colorCircle2 = (PulseCircleView *)[self viewWithTag:kColorCircle2Tag];
		self.colorCircle2.frequency = 4;
		self.colorCircle2.delegate = self;
		
		self.colorCircle3 = (PulseCircleView *)[self viewWithTag:kColorCircle3Tag];
		self.colorCircle3.frequency = 4;
		self.colorCircle3.delegate = self;
		
		self.colorCircle4 = (PulseCircleView *)[self viewWithTag:kColorCircle4Tag];
		self.colorCircle4.frequency = 4;
		self.colorCircle4.delegate = self;
		
		self.colorCircle5 = (PulseCircleView *)[self viewWithTag:kColorCircle5Tag];
		self.colorCircle5.frequency = 4;
		self.colorCircle5.delegate = self;
		
		self.soundCircle = (PulseCircleView *)[self viewWithTag:kSoundCircleTag];
		self.soundCircle.frequency = 8;
		self.soundCircle.amplitude = 8;
		self.soundCircle.delegate = self;
		
		[self _setColorScheme:scheme];
    }
	
    return self;
}

- (void)startAnimations
{
	[self.colorCircle1 startAnimation];
	[self.colorCircle2 startAnimation];
	[self.colorCircle3 startAnimation];
	[self.colorCircle4 startAnimation];
	[self.colorCircle5 startAnimation];
	[self.soundCircle startAnimation];
	[self.backgroundCircle startAnimation];
}

- (void)stopAnimations
{
	[self.colorCircle1 resetImmediately];
	[self.colorCircle2 resetImmediately];
	[self.colorCircle3 resetImmediately];
	[self.colorCircle4 resetImmediately];
	[self.colorCircle5 resetImmediately];
	[self.soundCircle resetImmediately];
	[self.backgroundCircle resetImmediately];
}

@end
