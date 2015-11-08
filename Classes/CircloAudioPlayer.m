//
//  CircloAudioPlayer.m
//  Circlo
//
//  Created by Johan Halin on 8.11.2015.
//  Copyright © 2015 Aero Deko. All rights reserved.
//

#import "CircloAudioPlayer.h"

@implementation CircloAudioPlayer

+ (instancetype)sharedPlayer
{
	static CircloAudioPlayer *sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlayer = [[self alloc] init];
	});
	
	return sharedPlayer;
}

- (void)loadSound:(NSString *)filename
{
}

- (void)playSound:(NSString *)filename loop:(BOOL)loop
{
}

- (void)stopSound:(NSString *)filename
{
}

- (void)setVolume:(double)volume forSound:(NSString *)filename
{
}

@end
