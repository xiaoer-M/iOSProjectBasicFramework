//
//  ZCConst.h
//  i84zcc
//
//  Created by 小二 on 2019/9/12.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCConst : NSObject
/********** 通知 **********/
UIKIT_EXTERN NSString * const ZCNotification_LoginSuccess;
UIKIT_EXTERN NSString * const ZCNotification_GetUserInfo;
UIKIT_EXTERN NSString * const ZCNotification_OutLogin;



/********** 接口 ***********/
/// api
UIKIT_EXTERN NSString * const ZCRequest_Api;
/// 登录
UIKIT_EXTERN NSString * const ZCRequest_Login;
/// 登出
UIKIT_EXTERN NSString * const ZCRequest_Logout;
/// 线路列表
UIKIT_EXTERN NSString * const ZCRequest_MyLineList;
/// 添加线路
UIKIT_EXTERN NSString * const ZCRequest_AddLine;
/// 删除线路
UIKIT_EXTERN NSString * const ZCRequest_DelLine;
/// 获取版本
UIKIT_EXTERN NSString * const ZCRequest_GetVersion;
/// 修改密码
UIKIT_EXTERN NSString * const ZCRequest_ChangePassword;
/// 个人信息
UIKIT_EXTERN NSString * const ZCRequest_PersonInfo;
/// 点名详情
UIKIT_EXTERN NSString * const ZCRequest_CallInfo;
/// 提交点名
UIKIT_EXTERN NSString * const ZCRequest_SubmitCall;
/// 线路重置
UIKIT_EXTERN NSString * const ZCRequest_LineReset;
/// 更换车辆
UIKIT_EXTERN NSString * const ZCRequest_ReplaceBus;
/// 获取当前服务器时间
UIKIT_EXTERN NSString * const ZCRequest_CurrentTime;
/// 联系家长
UIKIT_EXTERN NSString * const ZCRequest_MyParent;



@end

NS_ASSUME_NONNULL_END
