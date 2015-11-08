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

@property (nonatomic) NSTimeInterval frequency;
@property (nonatomic) NSInteger amplitude;
@property (nonatomic, weak) id delegate;
@property (nonatomic) BOOL circleHidden;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) CircloSoundType soundType;
@property (nonatomic) NSInteger soundNumber;
@property (nonatomic) BOOL selected;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleText button:(BOOL)button NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (void)startAnimation;
- (void)stopAnimation;
- (void)hide;
- (void)show;
- (void)resetImmediately;

@end

@protocol PulseCircleViewDelegate <NSObject>

- (void)touchUpInCircleView:(PulseCircleView *)circleView;

@end
