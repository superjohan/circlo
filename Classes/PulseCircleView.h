//
//  PulseCircleView.h
//  Circlo
//
//  Created by Johan Halin on 4/30/11.
//  Copyright 2011 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCircle.h"
#import "SoundManager.h"

@interface PulseCircleView : AbstractCircle 

@property (nonatomic, assign) NSTimeInterval frequency;
@property (nonatomic, assign) NSInteger amplitude;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) BOOL circleHidden;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CircloSoundType soundType;
@property (nonatomic, assign) NSInteger soundNumber;
@property (nonatomic, assign) BOOL selected;

- (id)initWithFrame:(CGRect)frame title:(NSString *)titleText button:(BOOL)button;
- (void)startAnimation;
- (void)stopAnimation;
- (void)hide;
- (void)show;
- (void)resetImmediately;

@end

@protocol PulseCircleViewDelegate <NSObject>

- (void)touchUpInCircleView:(PulseCircleView *)circleView;

@end
