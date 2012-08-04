//
//  ColorScheme.h
//  Circlo
//
//  Created by Johan Halin on 6/23/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	kColorSchemeNone = 0,
	kColorScheme1,
	kColorScheme2,
	kColorScheme3,
	kColorScheme4,
	kColorScheme5,
	kColorSchemeMax
} CircloColorSchemeType;

@interface ColorScheme : NSObject

@property (nonatomic, retain) UIColor *primaryColor;
@property (nonatomic, retain) UIColor *secondaryColor;
@property (nonatomic, assign) CircloColorSchemeType colorSchemeType;

- (id)initWithColorScheme:(CircloColorSchemeType)schemeType;

@end
