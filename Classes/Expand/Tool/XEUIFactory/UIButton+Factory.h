//
//  UIButton+Factory.h
//  i84zcc
//
//  Created by 小二 on 2019/9/4.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UIButtonClickActionBlock)(UIButton *sender);

@interface UIButton (Factory)

@property (nonatomic, copy) UIButtonClickActionBlock buttonBlock;

// ******************* 不带frame ******************

/**
 只有文字
 
 @param title 标题
 @param titleColor 标题字体颜色
 @param textFont 字体
 @param bgColor 背景颜色
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock;

/**
 字体、背景图片
 
 @param title 标题
 @param titleColor 标题字体颜色
 @param textFont 字体
 @param imageName 背景图片
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                  backgroundImageName:(NSString *)imageName
                               target:(UIButtonClickActionBlock)actionBlock;

/**
 字体、图片
 
 @param title 标题
 @param titleColor 标题字体颜色
 @param textFont 字体
 @param imageName 图片
 @param bgColor 背景颜色
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithTitle:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                            imageName:(NSString *)imageName
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock;

//************************* 带frame ***********************

/**
 只有文字

 @param frame 位置大小
 @param title 标题
 @param titleColor 标题字体颜色
 @param textFont 字体
 @param bgColor 背景颜色
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock;

/**
 字体、背景图片
 
 @param frame 位置大小
 @param title 标题
 @param titleColor 标题字体颜色
 @param imageName 背景图片
 @param textFont 字体
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                  backgroundImageName:(NSString *)imageName
                               target:(UIButtonClickActionBlock)actionBlock;

/**
 字体、图片

 @param frame 位置大小
 @param title 标题
 @param titleColor 标题字体颜色
 @param textFont 字体
 @param bgColor 背景颜色
 @param actionBlock 点击事件
 @return button对象
 */
+ (instancetype)createButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                           titleColor:(UIColor *)titleColor
                             textFont:(UIFont *)textFont
                            imageName:(NSString *)imageName
                      backgroundColor:(UIColor *)bgColor
                               target:(UIButtonClickActionBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
