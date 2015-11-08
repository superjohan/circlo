//
//  SoundManager.h
//  circlo
//
//  Created by Johan Halin on 6/29/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CircloSoundType)
{
	CircloSoundTypeHours = 1,
	CircloSoundTypeAMPM,
	CircloSoundTypeMinutesLeft,
	CircloSoundTypeMinutesRight
};

@interface SoundManager : NSObject

+ (void)loadSounds;
+ (void)playSound:(CircloSoundType)soundType number:(NSInteger)number;
+ (void)toggleSound;
+ (BOOL)soundOn;
+ (void)playBackgroundSound;
+ (void)updateBackgroundMusicVolumeWithHours:(NSInteger)hours minutes:(NSInteger)minutes;

@end
