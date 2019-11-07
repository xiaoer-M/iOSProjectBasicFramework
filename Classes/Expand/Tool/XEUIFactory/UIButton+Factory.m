//
//  UIButton+Factory.m
//  i84zcc
//
//  Created by 小二 on 2019/9/4.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "UIButton+Factory.h"
#import <objc/runtime.h>

static const void *kButtonBlock = "ButtonBlock";

@implementation UIButton (Factory)

+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:CGRectZero title:title titleColor:titleColor textFont:textFont imageName:@"" backgroundImageName:@"" backgroundColor:bgColor target:actionBlock];
}

+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                  backgroundImageName:(NSString *)imageName
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:CGRectZero title:title titleColor:titleColor textFont:textFont imageName:imageName backgroundImageName:@"" backgroundColor:[UIColor clearColor] target:actionBlock];
}

+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                            imageName:(NSString *)imageName
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:CGRectZero title:title titleColor:titleColor textFont:textFont imageName:imageName backgroundImageName:@"" backgroundColor:bgColor target:actionBlock];
}

+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:frame title:title titleColor:titleColor textFont:textFont imageName:@"" backgroundImageName:@"" backgroundColor:bgColor target:actionBlock];
}

+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                  backgroundImageName:(NSString *)imageName
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:frame title:title titleColor:titleColor textFont:textFont imageName:@"" backgroundImageName:imageName backgroundColor:[UIColor clearColor] target:actionBlock];
}

+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                            imageName:(NSString *)imageName
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock {
    return [self createButtonWithFrame:frame title:title titleColor:titleColor textFont:textFont imageName:imageName backgroundImageName:@"" backgroundColor:bgColor target:actionBlock];
}

+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                            imageName:(NSString *)imageName
                  backgroundImageName:(NSString *)bgImageName
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = textFont;
    if (!SCIsEmptyString(imageName)) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (!SCIsEmptyString(bgImageName)) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    button.backgroundColor = bgColor;
    [button addTarget:button action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.buttonBlock = actionBlock;
    return button;
}

- (void)buttonAction:(UIButton *)sender {
    !self.buttonBlock ?:self.buttonBlock(sender);
}

- (UIButtonClickActionBlock)buttonBlock {
    return objc_getAssociatedObject(self, kButtonBlock);
}

- (void)setButtonBlock:(UIButtonClickActionBlock)buttonBlock {
    objc_setAssociatedObject(self, kButtonBlock, buttonBlock, OBJC_ASSOCIATION_COPY);
}

@end
