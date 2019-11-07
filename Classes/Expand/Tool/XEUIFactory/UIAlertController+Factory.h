//
//  UIAlertController+Factory.h
//  i84zcc
//
//  Created by 小二 on 2019/9/17.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Factory)

/**
 单个按键的 alertController

 @param title 标题
 @param message 内容
 @param actionTitle 按键标题
 @param actionBlock 点击事件
 */
+ (void)presentAlertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                    actionTitle:(NSString *)actionTitle
                                        handler:(void(^)(UIAlertAction *action))actionBlock;

/**
 双按键的 alertController

 @param title 标题
 @param message 内容
 @param cancelTitle 左边按键
 @param defaultTitle 右边按键
 @param distinct 按键颜色是否区分(若 YES, 左按键为 UIAlertActionStyleCancel 模式 字体颜色偏深)
 @param cancelBlock 左边点击事件
 @param defaultBlock 右边点击事件
 */
+ (void)presentAlertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                    cancelTitle:(NSString *)cancelTitle
                                   defaultTitle:(NSString *)defaultTitle
                                       distinct:(BOOL)distinct
                                  cancelHandler:(void(^)(UIAlertAction *action))cancelBlock
                                 defaultHandler:(void(^)(UIAlertAction *action))defaultBlock;

/**
 任意多按键的 alertController (alertView or ActionSheet)

 @param title 标题
 @param message 内容
 @param actionTitles 按钮数组
 @param preferredStyle 显示类型
 @param actionBlock 点击事件
 */
+ (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                           actionTitles:(NSArray *)actionTitles
                         preferredStyle:(UIAlertControllerStyle)preferredStyle
                                handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))actionBlock;


@end

NS_ASSUME_NONNULL_END
