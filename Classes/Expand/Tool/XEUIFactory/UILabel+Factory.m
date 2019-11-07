//
//  UILabel+Factory.m
//  i84zcc
//
//  Created by 小二 on 2019/9/4.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "UILabel+Factory.h"

@implementation UILabel (Factory)

+ (instancetype)createLabelWithTextColor:(UIColor *)textColor
                                    font:(UIFont *)font
                           textAlignment:(NSTextAlignment)textAlignment
                         backgroundColor:(UIColor *)bgColor {
    return [self createLabelWithText:@"" textColor:textColor font:font textAlignment:textAlignment backgroundColor:bgColor];
}

+ (instancetype)createLabelWithText:(NSString *)text
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font
                      textAlignment:(NSTextAlignment)textAlignment
                    backgroundColor:(UIColor *)bgColor {
    return [self createLabelWithFrame:CGRectZero text:text textColor:textColor font:font textAlignment:textAlignment backgroundColor:bgColor];
}

+ (instancetype)createLabelWithFrame:(CGRect)frame
                                text:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                       textAlignment:(NSTextAlignment)textAlignment
                     backgroundColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    label.backgroundColor = bgColor;
    label.layer.masksToBounds = YES;
    return label;
}

@end
