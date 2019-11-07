//
//  MBProgressHUD+XE.m
//  i84zcc
//
//  Created by 小二 on 2019/9/12.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "MBProgressHUD+XE.h"

@implementation MBProgressHUD (XE)

+ (void)xe_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [MBProgressHUD xe_hideHUD];
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
    hud.mode = MBProgressHUDModeText;
    //所有内容为白色，包括菊花和文字
    hud.contentColor = [UIColor whiteColor];
    //把最新版本的MBProgressHUD修改为黑色背景
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //设置菊花框为白色
    //    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}


+ (void)xe_showSuccess:(NSString *)success
{
    [self xe_showSuccess:success toView:nil];
}


+ (void)xe_showSuccess:(NSString *)success toView:(UIView *)view
{
    [self xe_show:success icon:@"" view:view];
}


+ (void)xe_showError:(NSString *)error
{
    [self xe_showError:error toView:nil];
}


+ (void)xe_showError:(NSString *)error toView:(UIView *)view{
    [self xe_show:error icon:@"" view:view];
}


+ (MBProgressHUD *)xe_showMessage:(NSString *)message
{
    return [self xe_showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)xe_showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //所有内容为白色，包括菊花和文字
    hud.contentColor = [UIColor whiteColor];
    //把最新版本的MBProgressHUD修改为黑色背景
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //设置菊花框为白色
    //    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)xe_hideHUD
{
    [self xe_hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)xe_hideHUDForView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:NO];
}


@end
