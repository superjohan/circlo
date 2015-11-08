//
//  PulseCircleView.m
//  Circlo
//
//  Created by Johan Halin on 4/30/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "PulseCircleView.h"
#import "Circle.h"
#import "CircloConstants.h"

@interface PulseCircleView ()
@property (nonatomic) Circle *circle1;
@property (nonatomic) Circle *circle2;
@property (nonatomic) Circle *circle3;
@property (nonatomic) Circle *circle4;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) CGSize circleSize;
@property (nonatomic) UIButton *button;
@end

@implementation PulseCircleView

@synthesize textColor = _textColor;
@synthesize selected = _selected;

#pragma mark - Constants

static const NSTimeInterval kDefaultFrequency = 0.6;

#pragma mark - Private

- (void)_performHide
{
	UIViewAnimationOptions opts = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAllowUserInteraction;
		
	__weak PulseCircleView *bself = self;
	
	NSTimeInterval hideDuration = 1.0; //self.frequency;
	
	[UIView animateWithDuration:hideDuration delay:0 options:opts animations:^{
		bself.circle1.frame = CGRectMake(bself.circleSize.width / 2, bself.circleSize.height / 2, 0, 0);
		bself.circle2.frame = bself.circle1.frame;
		bself.circle3.frame = bself.circle1.frame;
		bself.circle4.frame = bself.circle1.frame;
		bself.button.alpha = 0;
	} completion:^(BOOL finished) {
	}];
}

- (void)_performShow
{
	UIViewAnimationOptions opts = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionAllowUserInteraction;
	
	__weak PulseCircleView *bself = self;
		
	NSTimeInterval showDuration = 1.0;
	
	[UIView animateWithDuration:showDuration delay:0 options:opts animations:^{
		bself.circle1.frame = CGRectMake(0, 0, bself.circleSize.width, bself.circleSize.height);
		bself.circle2.frame = bself.circle1.frame;
		bself.circle3.frame = bself.circle1.frame;
		bself.circle4.frame = bself.circle1.frame;
		bself.button.alpha = 1;
	} completion:^(BOOL finished) {
	}];
}

- (void)_performAnimation
{
	UIViewAnimationOptions opts = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState;
	
	self.circle1.frame = CGRectMake(0, 0, self.circle1.frame.size.width, self.circle1.frame.size.height);
	self.circle2.frame = self.circle1.frame;
	self.circle3.frame = self.circle1.frame;
	self.circle4.frame = self.circle1.frame;
	
	__weak PulseCircleView *bself = self;
	__block CGFloat rand1X = (arc4random() % self.amplitude) + 1;
	__block CGFloat rand1Y = (arc4random() % self.amplitude) + 1;
		
	[UIView animateWithDuration:(self.frequency / 2) delay:0 options:opts animations:^{
		bself.circle1.frame = CGRectMake(bself.bounds.origin.x + rand1X, bself.bounds.origin.y + rand1Y, bself.circle1.frame.size.width, bself.circle1.frame.size.height);
		bself.circle2.frame = CGRectMake(bself.bounds.origin.x - rand1X, bself.bounds.origin.y - rand1Y, bself.circle2.frame.size.width, bself.circle2.frame.size.height);
		bself.circle3.frame = CGRectMake(bself.bounds.origin.x + rand1X, bself.bounds.origin.y - rand1Y, bself.circle3.frame.size.width, bself.circle3.frame.size.height);
		bself.circle4.frame = CGRectMake(bself.bounds.origin.x - rand1X, bself.bounds.origin.y + rand1Y, bself.circle4.frame.size.width, bself.circle4.frame.size.height);
	} completion:^(BOOL finished) {		
	}];
	
	[SoundManager playSound:self.soundType number:self.soundNumber];
}

- (void)_touchUpInside
{
	if ([self.delegate respondsToSelector:@selector(touchUpInCircleView:)])
	{
		[self.delegate touchUpInCircleView:self];
	}

	[self startAnimation];
}

- (void)_forceCircleDisplay
{
	[self.circle1 setNeedsDisplay];
	[self.circle2 setNeedsDisplay];
	[self.circle3 setNeedsDisplay];
	[self.circle4 setNeedsDisplay];
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame title:(NSString *)titleText button:(BOOL)buttonUsed
{
    if ((self = [super initWithFrame:frame])) 
	{		
		self.circle1 = [[Circle alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		self.circle1.alpha = 0.5;
		self.circle1.userInteractionEnabled = NO;
		[self addSubview:self.circle1];

		self.circle2 = [[Circle alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		self.circle2.alpha = self.circle1.alpha;
		self.circle2.userInteractionEnabled = self.circle1.userInteractionEnabled;
		[self addSubview:self.circle2];

		self.circle3 = [[Circle alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		self.circle3.alpha = self.circle1.alpha;
		self.circle3.userInteractionEnabled = self.circle1.userInteractionEnabled;
		[self addSubview:self.circle3];

		self.circle4 = [[Circle alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		self.circle4.alpha = self.circle1.alpha;
		self.circle4.userInteractionEnabled = self.circle1.userInteractionEnabled;
		[self addSubview:self.circle4];
				
		if (buttonUsed)
		{
			self.button = [UIButton buttonWithType:UIButtonTypeCustom];
			self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
			self.button.titleLabel.font = [UIFont fontWithName:kCircleViewButtonFont size:floor(frame.size.width / 4.0)];
			self.button.titleLabel.textColor = [UIColor whiteColor];
			[self.button addTarget:self action:@selector(_touchUpInside) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:self.button];
			
			if (titleText)
			{
				[self.button setTitle:titleText forState:UIControlStateNormal];
			}
		}
		
		self.opaque = NO;
		self.circleSize = frame.size;
		self.savedCenter = self.center;
		self.savedFrame = frame;
		self.amplitude = 5;
		self.selected = YES;
	}
	
    return self;
}

- (void)startAnimation
{
	if (self.timer || self.circleHidden)
	{
		return;
	}
	
	if (self.frequency < 0.001)
	{
		self.frequency = kDefaultFrequency;
	}
	
	[self _performAnimation];
	
	self.timer = [NSTimer timerWithTimeInterval:self.frequency target:self selector:@selector(_performAnimation) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopAnimation
{
	if (self.circleHidden)
	{
		return;
	}
	
	if (self.timer)
	{
		[self.timer invalidate];
		self.timer = nil;
	}
}

- (void)hide
{
	if (self.circleHidden)
	{
		return;
	}
	
	[self stopAnimation];
	[self _performHide];
	self.circleHidden = YES;
}


- (void)show
{
	if (self.circleHidden == NO)
	{
		return;
	}
	
	[self _forceCircleDisplay];
	[self _performShow];
	self.circleHidden = NO;
	[self startAnimation];
}

- (void)resetImmediately
{
	if (self.circleHidden)
	{
		return;
	}
	
	[self stopAnimation];
	
	self.circle1.frame = CGRectMake(0, 0, self.circle1.frame.size.width, self.circle1.frame.size.height);
	self.circle2.frame = CGRectMake(0, 0, self.circle2.frame.size.width, self.circle2.frame.size.height);
	self.circle3.frame = CGRectMake(0, 0, self.circle3.frame.size.width, self.circle3.frame.size.height);
	self.circle4.frame = CGRectMake(0, 0, self.circle4.frame.size.width, self.circle4.frame.size.height);
}

- (void)setTextColor:(UIColor *)textColor
{
	[self.button setTitleColor:textColor forState:UIControlStateNormal];
	[self.button setTitleColor:textColor forState:UIControlStateHighlighted];
	
	_textColor = textColor;
}

- (void)setColor:(UIColor *)newColor
{
	self.circle1.color = newColor;
	self.circle2.color = newColor;
	self.circle3.color = newColor;
	self.circle4.color = newColor;
	
	[self _forceCircleDisplay];
	
	[super setColor:newColor];
}

- (void)setSelected:(BOOL)selected
{
	if (selected)
	{
		self.circle1.alpha = 0.50;
		self.circle2.alpha = self.circle1.alpha;
		self.circle3.alpha = self.circle1.alpha;
		self.circle4.alpha = self.circle1.alpha;
	}
	else
	{
		self.circle1.alpha = 0.1;
		self.circle2.alpha = self.circle1.alpha;
		self.circle3.alpha = self.circle1.alpha;
		self.circle4.alpha = self.circle1.alpha;
	}

	_selected = selected;
}

@end
