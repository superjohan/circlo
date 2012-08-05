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

- (id)initWithFrame:(CGRect)frame colorScheme:(ColorScheme *)scheme;
- (void)startAnimations;
- (void)stopAnimations;

@end

@protocol MenuViewDelegate <NSObject>

- (void)overlayButtonTouchedInMenuView:(MenuView *)menuView;
- (ColorScheme *)menuView:(MenuView *)menuView changedToColorScheme:(CircloColorSchemeType)schemeType;

@end