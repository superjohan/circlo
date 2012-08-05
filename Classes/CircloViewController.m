//
//  CircloViewController.m
//  Circlo
//
//  Created by Johan Halin on 5/5/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "CircloViewController.h"
#import "PulseCircleView.h"
#import "LayoutManager.h"
#import "ReactiveCircleView.h"
#import "Circle.h"
#import "MenuView.h"
#import "ColorSchemeManager.h"
#import "SoundManager.h"

@interface CircloViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, strong) ReactiveCircleView *reactiveCircleView;
@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic, strong) ColorScheme *colorScheme;
@property (nonatomic, strong) NSDateFormatter *hourFormatter;
@property (nonatomic, strong) NSDateFormatter *minuteFormatter;
@end

@implementation CircloViewController

#pragma mark -
#pragma mark Synthesizes

@synthesize timer;
@synthesize hours;
@synthesize minutes;
@synthesize reactiveCircleView;
@synthesize menuView;
@synthesize colorScheme;
@synthesize hourFormatter;
@synthesize minuteFormatter;


#pragma mark -
#pragma mark Constants

static const NSInteger kMaxHoursTag = 13;
static const NSInteger kAMTag = 13;
static const NSInteger kPMTag = 14;


#pragma mark -
#pragma mark Private

- (NSString *)_buttonTextForTag:(NSInteger)tag
{
	if (tag < kMaxHoursTag)
		return [NSString stringWithFormat:@"%d", kMaxHoursTag - tag];
	
	if (tag == kAMTag)
		return NSLocalizedString(@"AM", nil);
	
	if (tag == kPMTag)
		return NSLocalizedString(@"PM", nil);
	
	return [NSString stringWithFormat:@"%d", tag];
}


- (void)_layoutHours:(NSInteger)hrs
{
	if (self.hours == hrs)
		return;
	
	BOOL afternoon = NO;
	if (hrs == 0)
	{
		hrs = 12;
	}
	else if (hrs >= 12)
	{
		afternoon = YES;

		if (hrs > 12)
			hrs = hrs - 12;
	}
	
	for (NSInteger i = 1; i < kMaxHoursTag; i++)
	{
		PulseCircleView *circ = (PulseCircleView *)[self.view viewWithTag:kMaxHoursTag - i];
		
		if (i <= hrs)
			[circ show];
		else
			[circ hide];
	}
	
	PulseCircleView *amCircle = (PulseCircleView *)[self.view viewWithTag:kAMTag];
	PulseCircleView *pmCircle = (PulseCircleView *)[self.view viewWithTag:kPMTag];
	if (afternoon)
	{
		[amCircle hide];
		[pmCircle show];
	}
	else
	{
		[amCircle show];
		[pmCircle hide];
	}
	
	self.hours = hrs;
}


- (void)_layoutMinutes:(NSInteger)mins
{
	if (self.minutes == mins)
		return;
	
	NSInteger rightNumber = mins % 10;
	NSInteger leftNumber = (mins - rightNumber) / 10;
	
	// left
	for (NSInteger i = 0; i < 6; i++)
	{
		PulseCircleView *circ = (PulseCircleView *)[self.view viewWithTag:15 + i];
		
		if (leftNumber == 0)
		{
			[circ show];
		}
		else
		{
			if (i <= leftNumber - 1)
				[circ show];
			else
				[circ hide];
		}
	}
	
	// right
	for (NSInteger i = 0; i < 10; i++)
	{
		PulseCircleView *circ = (PulseCircleView *)[self.view viewWithTag:21 + i];
		
		if (rightNumber == 0)
		{
			[circ show];
		}
		else
		{
			if (i <= rightNumber - 1)
				[circ show];
			else
				[circ hide];
		}
	}
	
	self.minutes = mins;
}


- (void)_configureDateFormatters
{
	self.hourFormatter = [[NSDateFormatter alloc] init];
	self.minuteFormatter = [[NSDateFormatter alloc] init];
	
	[self.hourFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"]];
	[self.minuteFormatter setLocale:self.hourFormatter.locale];
	
	[self.hourFormatter setDateFormat:@"HH"];
	[self.minuteFormatter setDateFormat:@"mm"];
}


- (void)_updateClock:(NSTimer *)timer
{
	NSDate *date = [NSDate date];

	NSInteger hrs = [[self.hourFormatter stringFromDate:date] integerValue];
	[self _layoutHours:hrs];
	
	NSInteger mins = [[self.minuteFormatter stringFromDate:date] integerValue];
	[self _layoutMinutes:mins];
	
	[SoundManager updateBackgroundMusicVolumeWithHours:hrs minutes:mins];
}


- (void)_startTimer
{
	if (self.timer)
		return;
	
	[UIApplication sharedApplication].idleTimerDisabled = YES;

	self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(_updateClock:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


- (void)_stopTimer
{
	if (self.timer)
	{
		[self.timer invalidate];
		self.timer = nil;

		[UIApplication sharedApplication].idleTimerDisabled = YES;
	}
}


- (void)_handleDoubleTap:(UITapGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateEnded)
	{
		[self.menuView startAnimations];
		
		__weak CircloViewController *bself = self;

		[UIView animateWithDuration:1 animations:^{
			bself.menuView.alpha = 1;
		}];
	}
}


- (void)_setColorScheme:(ColorScheme *)scheme
{
	self.colorScheme = scheme;
	self.view.backgroundColor = scheme.secondaryColor;
	
	for (AbstractCircle *circle in [self.reactiveCircleView subviews])
	{
		circle.color = scheme.primaryColor;
	}
}


- (ColorScheme *)_changeToColorScheme:(CircloColorSchemeType)schemeType
{
	ColorScheme *scheme = [ColorSchemeManager changeToColorScheme:schemeType];
	
	[self _setColorScheme:scheme];

	return scheme;
}


- (void)_fadeOutStartupImage
{
	__block UIImageView *startupImageView = nil;
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
		startupImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Portrait"]];
	else
		startupImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
	
	startupImageView.frame = CGRectMake(0, 0, startupImageView.image.size.width, startupImageView.image.size.height);
	[self.view addSubview:startupImageView];
	
	[UIView animateWithDuration:2.0 delay:1 options:0 animations:^{
		startupImageView.alpha = 0;
	} completion:^(BOOL finished) {
		[startupImageView removeFromSuperview];
		startupImageView = nil;
	}];
}


#pragma mark -
#pragma mark MenuViewDelegate

- (void)overlayButtonTouchedInMenuView:(MenuView *)menuView
{
	__weak CircloViewController *bself = self;
	
	[UIView animateWithDuration:1 animations:^{
		bself.menuView.alpha = 0;
	} completion:^(BOOL finished) {
		[bself.menuView stopAnimations];
	}];
}


- (ColorScheme *)menuView:(MenuView *)menuView changedToColorScheme:(CircloColorSchemeType)schemeType
{
	return [self _changeToColorScheme:schemeType];
}


#pragma mark -
#pragma mark Public

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.hours = -1;
	self.minutes = -1;
	
	self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
	self.reactiveCircleView = [[ReactiveCircleView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:self.reactiveCircleView];
	[self.reactiveCircleView becomeFirstResponder];
	
	[LayoutManager createClockLayoutInView:self.reactiveCircleView];

	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleDoubleTap:)];
	tapRecognizer.numberOfTapsRequired = 2;
	tapRecognizer.delaysTouchesEnded = NO;
	[self.reactiveCircleView addGestureRecognizer:tapRecognizer];
		
	[self _setColorScheme:[ColorSchemeManager getSavedColorScheme]];
	
	self.menuView = [[MenuView alloc] initWithFrame:self.view.bounds colorScheme:self.colorScheme];
	self.menuView.alpha = 0;
	self.menuView.delegate = self;
	[self.view addSubview:self.menuView];
	
	[SoundManager loadSounds];
	[SoundManager playBackgroundSound];
	
	[self _configureDateFormatters];
	[self _startTimer];	
	[self _fadeOutStartupImage];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc 
{
	[self _stopTimer];
	
	
}


- (void)startAllCircleAnimations
{
	for (id view in [self.reactiveCircleView subviews])
	{
		if ([view isKindOfClass:[PulseCircleView class]])
		{
			PulseCircleView *circle = view;
			
			[circle startAnimation];
		}
	}
	
	[self _startTimer];
}


- (void)stopAllCircleAnimations
{
	for (id view in [self.reactiveCircleView subviews])
	{
		if ([view isKindOfClass:[PulseCircleView class]])
		{
			PulseCircleView *circle = view;
			
			[circle resetImmediately];
		}
	}
	
	[self _stopTimer];
}


@end
