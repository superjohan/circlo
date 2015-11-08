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
@property (nonatomic) NSMutableDictionary<NSString *, NSArray<AVAudioPlayer *> *> *players;
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

- (AVAudioPlayer *)_audioPlayerForURL:(NSURL *)url
{
	NSError *error = nil;
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	if (audioPlayer == nil)
	{
		NSLog(@"%@", error);
		
		return nil;
	}
	
	return audioPlayer;
}

- (AVAudioPlayer *)_freePlayerForFilename:(NSString *)filename
{
	__block AVAudioPlayer *player = nil;
		
	[self _performBlockOnAudioPlayers:filename block:^(AVAudioPlayer *audioPlayer, BOOL *stop) {
		if (audioPlayer.playing == NO)
		{
			player = audioPlayer;
			
			*stop = YES;
		}
		
		if (player == nil || audioPlayer.currentTime > player.currentTime)
		{
			player = audioPlayer;
		}
	}];
	
	return player;
}

- (void)_performBlockOnAudioPlayers:(NSString *)filename block:(void (^)(AVAudioPlayer *, BOOL *stop))block
{
	NSArray *players = self.players[filename];
	
	for (AVAudioPlayer *player in players)
	{
		BOOL shouldStop = NO;
		
		block(player, &shouldStop);
		
		if (shouldStop == YES)
		{
			break;
		}
	}
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

- (void)loadSound:(NSString *)filename multitrack:(BOOL)multitrack
{
	if (self.players[filename] != nil)
	{
		NSLog(@"Player already exists for filename '%@'.", filename);
		
		return;
	}
	
	NSMutableArray *players = [NSMutableArray array];
	NSInteger playerCount = multitrack ? 2 : 1;
	NSURL *url = [self _urlForFilename:filename];
	
	for (NSInteger i = 0; i < playerCount; i++)
	{
		AVAudioPlayer *player = [self _audioPlayerForURL:url];
		if (player == nil)
		{
			return;
		}
		
		[players addObject:player];
	}
	
	self.players[filename] = players;
}

- (void)playSound:(NSString *)filename loop:(BOOL)loop
{
	AVAudioPlayer *audioPlayer = [self _freePlayerForFilename:filename];
	if (audioPlayer == nil)
	{
		[self loadSound:filename multitrack:YES];
	}

	if (audioPlayer.playing)
	{
		[audioPlayer stop];
		audioPlayer.currentTime = 0;
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
	[self _performBlockOnAudioPlayers:filename block:^(AVAudioPlayer *player, BOOL *stop) {
		[player stop];
		player.currentTime = 0;
	}];
}

- (void)setVolume:(float)volume forSound:(NSString *)filename
{
	[self _performBlockOnAudioPlayers:filename block:^(AVAudioPlayer *player, BOOL *stop) {
		player.volume = volume;
	}];
}

@end
