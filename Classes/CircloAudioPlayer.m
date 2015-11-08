//
//  CircloAudioPlayer.m
//  Circlo
//
//  Created by Johan Halin on 8.11.2015.
//  Copyright © 2015 Aero Deko. All rights reserved.
//

@import AVFoundation;

#import "CircloAudioPlayer.h"

@interface CircloAudioPlayer ()
@property (nonatomic) NSMutableDictionary *players;
@end

@implementation CircloAudioPlayer

#pragma mark - Private

- (NSURL *)_urlForFilename:(NSString *)filename
{
	if (filename == nil)
	{
		NSLog(@"Filename is nil.");
		
		return nil;
	}
	
	// This is a bad assumption, but is okay in this case. *shrug*
	NSArray *components = [filename componentsSeparatedByString:@"."];
	
	if (components.count != 2)
	{
		NSLog(@"Invalid filename.");
		
		return nil;
	}
	
	return [[NSBundle mainBundle] URLForResource:components[0] withExtension:components[1]];
}

#pragma mark - Public

+ (instancetype)sharedPlayer
{
	static CircloAudioPlayer *sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlayer = [[self alloc] init];
	});
	
	return sharedPlayer;
}

- (instancetype)init
{
	if ((self = [super init]))
	{
		_players = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)loadSound:(NSString *)filename
{
	if (self.players[filename] != nil)
	{
		NSLog(@"Player already exists for filename '%@'.", filename);
		
		return;
	}
	
	NSError *error = nil;
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self _urlForFilename:filename] error:&error];
	if (audioPlayer == nil)
	{
		NSLog(@"%@", error);

		return;
	}
	
	self.players[filename] = audioPlayer;
}

- (void)playSound:(NSString *)filename loop:(BOOL)loop
{
	AVAudioPlayer *audioPlayer = self.players[filename];
	if (audioPlayer == nil)
	{
		[self loadSound:filename];
	}

	if (audioPlayer.playing)
	{
		[audioPlayer stop];
	}
	
	[audioPlayer prepareToPlay];

	if (loop)
	{
		audioPlayer.numberOfLoops = -1;
	}

	[audioPlayer play];
}

- (void)stopSound:(NSString *)filename
{
	AVAudioPlayer *audioPlayer = self.players[filename];
	if (audioPlayer == nil)
	{
		NSLog(@"No sound to stop.");
		
		return;
	}
	
	[audioPlayer stop];
}

- (void)setVolume:(float)volume forSound:(NSString *)filename
{
	AVAudioPlayer *audioPlayer = self.players[filename];
	if (audioPlayer == nil)
	{
		NSLog(@"No sound to set the volume for.");
		
		return;
	}
	
	audioPlayer.volume = volume;
}

@end
