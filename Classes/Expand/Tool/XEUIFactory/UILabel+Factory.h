//
//  UILabel+Factory.h
//  i84zcc
//
//  Created by 小二 on 2019/9/4.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Factory)

/**
 常用lable创建3

 @param textColor 字体颜色
 @param font 字体
 @param textAlignment 字体显示方式
 @param bgColor 背景颜色，默认白色
 @return lable对象
 */
+ (instancetype)createLabelWithTextColor:(UIColor *)textColor
                                    font:(UIFont *)font
                           textAlignment:(NSTextAlignment)textAlignment
                         backgroundColor:(UIColor *)bgColor;

/**
 常用lable创建2

 @param text 标题
 @param textColor 字体颜色
 @param font 字体
 @param textAlignment 字体显示方式
 @param bgColor 背景颜色，默认白色
 @return lable对象
 */
+ (instancetype)createLabelWithText:(NSString *)text
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font
                      textAlignment:(NSTextAlignment)textAlignment
                    backgroundColor:(UIColor *)bgColor;

/**
 常用lable创建1

 @param frame 大小
 @param text 标题
 @param textColor 字体颜色
 @param font 字体
 @param textAlignment 字体显示方式
 @param bgColor 背景颜色，默认白色
 @return lable对象
 */
+ (instancetype)createLabelWithFrame:(CGRect)frame
                                text:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                       textAlignment:(NSTextAlignment)textAlignment
                     backgroundColor:(UIColor *)bgColor;
@end

NS_ASSUME_NONNULL_END
