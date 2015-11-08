//
//  ColorSchemeManager.m
//  Circlo
//
//  Created by Johan Halin on 6/23/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import "ColorSchemeManager.h"
#import "CircloConstants.h"

@implementation ColorSchemeManager

+ (ColorScheme *)changeToColorScheme:(CircloColorSchemeType)schemeType
{
	ColorScheme *scheme = [[ColorScheme alloc] initWithColorScheme:schemeType];
	
	[[NSUserDefaults standardUserDefaults] setInteger:schemeType forKey:kCircloUserDefaultsColorScheme];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	return scheme;
}

+ (ColorScheme *)getSavedColorScheme
{	
	CircloColorSchemeType schemeType = [[NSUserDefaults standardUserDefaults] integerForKey:kCircloUserDefaultsColorScheme];
	
	if (schemeType == CircloColorSchemeNone || schemeType >= CircloColorSchemeMax)
	{
		return [[self class] changeToColorScheme:CircloColorScheme1];
	}
	else
	{
		return [[ColorScheme alloc] initWithColorScheme:schemeType];
	}
}

@end
