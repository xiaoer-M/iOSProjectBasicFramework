//
//  MBProgressHUD+XE.h
//  i84zcc
//
//  Created by 小二 on 2019/9/12.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (XE)

///成功
+ (void)xe_showSuccess:(NSString *)success;
+ (void)xe_showSuccess:(NSString *)success toView:(UIView * _Nullable)view;

///失败
+ (void)xe_showError:(NSString *)error;
+ (void)xe_showError:(NSString *)error toView:(UIView * _Nullable)view;

///提示信息
+ (MBProgressHUD *)xe_showMessage:(NSString *)message;
+ (MBProgressHUD *)xe_showMessage:(NSString *)message toView:(UIView * _Nullable)view;

///隐藏
+ (void)xe_hideHUD;
+ (void)xe_hideHUDForView:(UIView * _Nullable)view;

@end

NS_ASSUME_NONNULL_END
