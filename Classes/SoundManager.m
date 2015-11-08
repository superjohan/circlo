//
//  SoundManager.m
//  circlo
//
//  Created by Johan Halin on 6/29/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "SoundManager.h"
#import "CircloAudioPlayer.h"
#import "CircloConstants.h"

@implementation SoundManager

+ (void)loadSounds
{
	// hours
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-1.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-2.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-3.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-4.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-5.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-6.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-7.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-8.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-9.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-10.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-11.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"1-12.caf" multitrack:YES];

	// am/pm
	[[CircloAudioPlayer sharedPlayer] loadSound:@"2-1.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"2-2.caf" multitrack:YES];

	// minutes, first digit
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-1.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-2.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-3.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-4.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-5.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"3-6.caf" multitrack:YES];

	// minutes, second digit
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-1.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-2.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-3.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-4.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-5.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-6.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-7.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-8.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-9.caf" multitrack:YES];
	[[CircloAudioPlayer sharedPlayer] loadSound:@"4-10.caf" multitrack:YES];
	
	// background sound
	[[CircloAudioPlayer sharedPlayer] loadSound:@"bg.m4a" multitrack:NO];
}

+ (void)playSound:(CircloSoundType)soundType number:(NSInteger)number
{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kCircloUserDefaultsSoundEnabled])
	{
		[[CircloAudioPlayer sharedPlayer] playSound:[NSString stringWithFormat:@"%ld-%ld.caf", soundType, number] loop:NO];
	}
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
	{
		[[CircloAudioPlayer sharedPlayer] playSound:@"bg.m4a" loop:YES];
	}
	else
	{
		[[CircloAudioPlayer sharedPlayer] stopSound:@"bg.m4a"];
	}
}

+ (void)updateBackgroundMusicVolumeWithHours:(NSInteger)hours minutes:(NSInteger)minutes
{
	if (hours > 12)
	{
		hours = hours - 12;
	}
	
	double firstDecimal = (double)hours / 12.0;
	double secondDecimal = (hours < 12) ? ((double)minutes / 60.0) / 10.0 : 0;
	
	[[CircloAudioPlayer sharedPlayer] setVolume:(firstDecimal + secondDecimal) forSound:@"bg.m4a"];
}

@end
