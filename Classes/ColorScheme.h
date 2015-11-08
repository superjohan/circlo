//
//  ColorScheme.h
//  Circlo
//
//  Created by Johan Halin on 6/23/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CircloColorSchemeType)
{
	CircloColorSchemeNone = 0,
	CircloColorScheme1,
	CircloColorScheme2,
	CircloColorScheme3,
	CircloColorScheme4,
	CircloColorScheme5,
	CircloColorSchemeMax
};

@interface ColorScheme : NSObject

@property (nonatomic) UIColor *primaryColor;
@property (nonatomic) UIColor *secondaryColor;
@property (nonatomic) CircloColorSchemeType colorSchemeType;

- (instancetype)initWithColorScheme:(CircloColorSchemeType)schemeType NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
