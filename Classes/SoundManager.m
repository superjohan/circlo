//
//  SoundManager.m
//  circlo
//
//  Created by Johan Halin on 6/29/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "SoundManager.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
#import "CircloConstants.h"

@implementation SoundManager

+ (void)loadSounds
{
	// hours
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-1.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-2.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-3.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-4.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-5.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-6.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-7.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-8.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-9.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-10.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-11.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"1-12.caf"];

	// am/pm
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"2-1.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"2-2.caf"];

	// minutes, first digit
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-1.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-2.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-3.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-4.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-5.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"3-6.caf"];

	// minutes, second digit
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-1.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-2.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-3.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-4.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-5.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-6.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-7.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-8.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-9.caf"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"4-10.caf"];
	
	// background sound
	[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg.m4a"];
}


+ (void)playSound:(CircloSoundType)soundType number:(NSInteger)number
{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsSoundEnabled])
		[[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%d-%d.caf", soundType, number]];
}


+ (void)toggleSound
{
	BOOL sound = [[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsSoundEnabled];
	
	[[NSUserDefaults standardUserDefaults] setBool:!sound forKey:kCircloUserDefaultsSoundEnabled];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[[self class] playBackgroundSound];
}


+ (BOOL)soundOn
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsSoundEnabled];
}


+ (void)playBackgroundSound
{
	if ([[self class] soundOn])
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bg.m4a" loop:YES];
	else
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}


+ (void)updateBackgroundMusicVolumeWithHours:(NSInteger)hours minutes:(NSInteger)minutes
{
	if (hours > 12)
		hours = hours - 12;
	
	double firstDecimal = (double)hours / 12.0;
	double secondDecimal = (hours < 12) ? ((double)minutes / 60.0) / 10.0 : 0;
	
	[[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:(firstDecimal + secondDecimal)];
}


@end
