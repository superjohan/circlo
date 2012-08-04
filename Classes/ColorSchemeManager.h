//
//  ColorSchemeManager.h
//  Circlo
//
//  Created by Johan Halin on 6/23/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorScheme.h"

@interface ColorSchemeManager : NSObject

+ (ColorScheme *)changeToColorScheme:(CircloColorSchemeType)schemeType;
+ (ColorScheme *)getSavedColorScheme;

@end
