//
//  ColorScheme.m
//  Circlo
//
//  Created by Johan Halin on 6/23/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "ColorScheme.h"
#import "ColorSchemeManager.h"

NSString * const kColorSchemePrimaryColorKey = @"kColorSchemePrimaryColorKey";
NSString * const kColorSchemeSecondaryColorKey = @"kColorSchemeSecondaryColorKey";

@implementation ColorScheme

#pragma mark - Private

- (UIColor *)_primaryColorForColorScheme:(CircloColorSchemeType)schemeType
{
	switch(schemeType) 
	{
		case kColorScheme1:
			return [UIColor colorWithRed:(255.0 / 255.0) green:(0 / 255.0) blue:(128.0 / 255.0) alpha:1];
			break;
		case kColorScheme2:
			return [UIColor colorWithRed:(0 / 255.0) green:(0 / 255.0) blue:(0 / 255.0) alpha:1];
			break;
		case kColorScheme3:
			return [UIColor colorWithRed:(254.0 / 255.0) green:(176.0 / 255.0) blue:(140.0 / 255.0) alpha:1];
			break;
		case kColorScheme4:
			return [UIColor colorWithRed:(254.0 / 255.0) green:(189.0 / 255.0) blue:(234.0 / 255.0) alpha:1];
			break;
		case kColorScheme5:
			return [UIColor colorWithRed:(75.0 / 255.0) green:(207.0 / 255.0) blue:(190.0 / 255.0) alpha:1];
			break;
		default:
			break;
	}
	
	return nil;
}

- (UIColor *)_secondaryColorForColorScheme:(CircloColorSchemeType)schemeType
{
	switch(schemeType) 
	{
		case kColorScheme1:
			return [UIColor colorWithRed:(255.0 / 255.0) green:(255.0 / 255.0) blue:(0 / 255.0) alpha:1];
			break;
		case kColorScheme2:
			return [UIColor colorWithRed:(254.0 / 255.0) green:(176.0 / 255.0) blue:(140.0 / 255.0) alpha:1];
			break;
		case kColorScheme3:
			return [UIColor colorWithRed:(255.0 / 255.0) green:(218.0 / 255.0) blue:(211.0 / 255.0) alpha:1];
			break;
		case kColorScheme4:
			return [UIColor colorWithRed:(107.0 / 255.0) green:(147.0 / 255.0) blue:(253.0 / 255.0) alpha:1];
			break;
		case kColorScheme5:
			return [UIColor colorWithRed:(255.0 / 255.0) green:(236.0 / 255.0) blue:(217.0 / 255.0) alpha:1];
			break;
		default:
			break;
	}
	
	return nil;
}

#pragma mark - Public

- (id)initWithColorScheme:(CircloColorSchemeType)schemeType
{
	if ((self = [super init]))
	{
		self.primaryColor = [self _primaryColorForColorScheme:schemeType];
		self.secondaryColor = [self _secondaryColorForColorScheme:schemeType];
		self.colorSchemeType = schemeType;
	}
	
	return self;
}

@end
