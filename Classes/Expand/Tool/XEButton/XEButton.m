//
//  XEButton.m
//  i84zcc
//
//  Created by 小二 on 2019/9/25.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XEButton.h"

@interface XEButton ()
// 该属性用来处理image设置为nil时实时更新buttonUI
@property (nonatomic, assign) BOOL isNullImage;

@end

@implementation XEButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.midSpacing = 8;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (self.layoutStyle) {
        case XELayoutButtonStyleLeftImageRightTitle:
            [self layoutHorizontalWithLeftView:self.imageView rightView:self.titleLabel];
            break;
        case XELayoutButtonStyleLeftTitleRightImage:
            [self layoutHorizontalWithLeftView:self.titleLabel rightView:self.imageView];
            break;
        case XELayoutButtonStyleUpImageDownTitle:
            [self layoutVerticalWithUpView:self.imageView downView:self.titleLabel];
            break;
        case XELayoutButtonStyleUpTitleDownImage:
            [self layoutVerticalWithUpView:self.titleLabel downView:self.imageView];
            break;
        default:
            break;
    }
}

- (void)layoutHorizontalWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    if (_isNullImage) {
        leftView = nil;
    }
    
    CGRect leftViewFrame = leftView.frame;
    CGRect rightViewFrame = rightView.frame;
    
    CGFloat totalWidth = CGRectGetWidth(leftViewFrame) + self.midSpacing + CGRectGetWidth(rightViewFrame);
    
    switch (self.layoutContent) {
        case XELayoutContentCenter:
            leftViewFrame.origin.x = (CGRectGetWidth(self.frame) - totalWidth) / 2.0;
            break;
        case XELayoutContentLeft:
            leftViewFrame.origin.x = 0;
            break;
        case XELayoutContentRight:
            leftViewFrame.origin.x = CGRectGetWidth(self.frame) - totalWidth;
            break;
        default:
            break;
    }
    
    leftViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(leftViewFrame)) / 2.0;
    leftView.frame = leftViewFrame;
    
    rightViewFrame.origin.x = CGRectGetMaxX(leftViewFrame) + self.midSpacing;
    rightViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(rightViewFrame)) / 2.0;
    rightView.frame = rightViewFrame;
}

- (void)layoutVerticalWithUpView:(UIView *)upView downView:(UIView *)downView {
    CGRect upViewFrame = upView.frame;
    CGRect downViewFrame = downView.frame;
    
    CGFloat totalHeight = CGRectGetHeight(upViewFrame) + self.midSpacing + CGRectGetHeight(downViewFrame);
    
    upViewFrame.origin.y = (CGRectGetHeight(self.frame) - totalHeight) / 2.0;
    upViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(upViewFrame)) / 2.0;
    upView.frame = upViewFrame;
    
    downViewFrame.origin.y = CGRectGetMaxY(upViewFrame) + self.midSpacing;
    downViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(downViewFrame)) / 2.0;
    downView.frame = downViewFrame;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    _isNullImage = image == nil ? YES : NO;
    [super setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

@end
