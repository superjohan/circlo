//
//  MenuView.h
//  Circlo
//
//  Created by Johan Halin on 6/22/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorScheme.h"

enum
{
	kColorCircle1Tag = 1,
	kColorCircle2Tag,
	kColorCircle3Tag,
	kColorCircle4Tag,
	kColorCircle5Tag,
	kSoundCircleTag,
	kOverlayButtonTag,
	kBackgroundCircleTag
};

@interface MenuView : UIView

@property (nonatomic, weak) id delegate;

- (instancetype)initWithFrame:(CGRect)frame colorScheme:(ColorScheme *)scheme NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (void)startAnimations;
- (void)stopAnimations;

@end

@protocol MenuViewDelegate <NSObject>

- (void)overlayButtonTouchedInMenuView:(MenuView *)menuView;
- (ColorScheme *)menuView:(MenuView *)menuView changedToColorScheme:(CircloColorSchemeType)schemeType;

@end