//
//  ZCLoginTool.h
//  i84zcc
//
//  Created by 小二 on 2019/9/16.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLoginModel.h"
#import "ZCUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCLoginTool : NSObject

///是否登录
@property (nonatomic, assign) BOOL isLogin;
///登录数据
@property (nonatomic, strong) ZCLoginModel *loginModel;
///个人信息
@property (nonatomic, strong) ZCUserModel *userModel;

/**
 单例

 @return 登录工具对象
 */
+ (ZCLoginTool *_Nullable)sharedLogin;

/**
 登录

 @param account 账号
 @param password 密码
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
+ (void)loginAppWithAccount:(NSString *)account password:(NSString *)password success:(XESuccessBlock)successBlock error:(XEErrorBlock)errorBlock;

/**
 获取个人信息
 
 @param successBlock 回调
 */
+ (void)getUserInfo:(XESuccessBlock)successBlock;

/**
 修改密码

 @param originalPswd 原始密码
 @param freshPswd 新密码
 @param confirmPswd 确认密码
 @param successBlock 成功回调
 */
+ (void)changePasswordWithOriginalPswd:(NSString *)originalPswd freshPswd:(NSString *)freshPswd confirmPswd:(NSString *)confirmPswd success:(XESuccessBlock)successBlock;

/**
 退出登录

 @param successBlock 回调
 */
+ (void)logoutApp:(XESuccessBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
