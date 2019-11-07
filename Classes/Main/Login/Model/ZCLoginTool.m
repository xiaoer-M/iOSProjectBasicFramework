//
//  ZCLoginTool.m
//  i84zcc
//
//  Created by 小二 on 2019/9/16.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCLoginTool.h"
#import "ZCInfoTool.h"
#import "XECheckUpdateTool.h"

@implementation ZCLoginTool

+ (ZCLoginTool *)sharedLogin {
    static ZCLoginTool *sharedLogin = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogin = [[ZCLoginTool alloc] init];
        sharedLogin.isLogin = NO;
    });
    return sharedLogin;
}

+ (void)loginAppWithAccount:(NSString *)account password:(NSString *)password success:(XESuccessBlock)successBlock error:(XEErrorBlock)errorBlock {
    if (SCIsEmptyString(account)) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Please enter a user name", nil)];
        return;
    }
    
    if (SCIsEmptyString(password)) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Please enter a password", nil)];
        return;
    }
    
    NSDictionary *params = @{@"username": account, @"password": password, @"rememberMe": @"true", @"manage": @"vip", @"isApp": @"1", @"isZgy": @"1"};
    
    [MBProgressHUD xe_showMessage:@""];
    [[XENetworkManager sharedManager] sendPostRequest:ZCRequest_Login parameters:params success:^(id responseObject) {
        [MBProgressHUD xe_hideHUD];
        
        NSDictionary *dic = [XENetworkUtils handleRequestSuccessResult:responseObject];
        
        if (SCIsEmptyDictonary(dic)) {
            successBlock(responseObject); // 成功失败都回调出去，方便普通登录和自动登录做单独处理
            return;
        }
        
        // 数据处理
        ZCLoginModel *model = [ZCLoginModel yy_modelWithDictionary:dic];
        [ZCLoginTool sharedLogin].loginModel = model;
        [ZCLoginTool sharedLogin].isLogin = YES;
        
        // 存储
        [ZCInfoTool setValue:account forKey:UserAccount];
        [ZCInfoTool setValue:password forKey:UserPassword];
        
        // 检查更新
        [XECheckUpdateTool cheackUpdate];
        
        //获取用户信息
        [self getUserInfo:^(id responseObject) {
        }];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCNotification_LoginSuccess object:nil];
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        errorBlock(error);
        [MBProgressHUD xe_hideHUD];
        [MBProgressHUD xe_showError:error.localizedDescription ?: ZCRequestErrorTip];
    }];
}


+ (void)getUserInfo:(XESuccessBlock)successBlock {
    NSDictionary *params = @{@"action": ZCRequest_PersonInfo};
    [[XENetworkManager sharedManager] sendPostRequest:ZCRequest_Api parameters:params success:^(id responseObject) {
        NSDictionary *dic = [XENetworkUtils handleRequestSuccessResult:responseObject];
        
        if (SCIsEmptyDictonary(dic)) {
            return;
        }
        
        ZCUserModel *userModel = [ZCUserModel yy_modelWithDictionary:dic];
        [ZCLoginTool sharedLogin].userModel = userModel;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCNotification_GetUserInfo object:nil];
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [MBProgressHUD xe_showError:error.localizedDescription ?: ZCRequestErrorTip];
    }];
}


+ (void)changePasswordWithOriginalPswd:(NSString *)originalPswd freshPswd:(NSString *)freshPswd confirmPswd:(NSString *)confirmPswd success:(XESuccessBlock)successBlock {
    
    if (SCIsEmptyString(originalPswd)) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Please enter the original password", nil)];
        return;
    }
    
    if (SCIsEmptyString(freshPswd)) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Please enter a new password", nil)];
        return;
    }
    
    if (SCIsEmptyString(confirmPswd)) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Please confirm the new password", nil)];
        return;
    }
    
    if (![freshPswd isEqualToString:confirmPswd]) {
        [MBProgressHUD xe_showError:NSLocalizedString(@"Verify that the password does not match the new password input", nil)];
        return;
    }
    
    NSDictionary *params = @{@"action": ZCRequest_ChangePassword,
                             @"originalPswd": originalPswd,
                             @"newPswd": freshPswd,
                             @"confirmPswd": confirmPswd
                             };
    [[XENetworkManager sharedManager] sendPostRequest:ZCRequest_Api parameters:params success:^(id responseObject) {
        NSNumber *result = [XENetworkUtils handleRequestSuccessResult:responseObject];
        
        if (![result boolValue]) {
            return;
        }
        
        [MBProgressHUD xe_showSuccess:NSLocalizedString(@"Modify success", nil)];
        
        // 替换原来的密码  
        [ZCInfoTool setValue:freshPswd forKey:UserPassword];
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [MBProgressHUD xe_showError:error.localizedDescription ?: ZCRequestErrorTip];
    }];
}


+ (void)logoutApp:(XESuccessBlock)successBlock {
    [[XENetworkManager sharedManager] sendPostRequest:ZCRequest_Logout parameters:nil success:^(id responseObject) {
        NSNumber *result = [XENetworkUtils handleRequestSuccessResult:responseObject];
        
        if (![result boolValue]) {
            return;
        }
        
        // 数据清理
        ZCLoginModel *model = [[ZCLoginModel alloc] init];
        [ZCLoginTool sharedLogin].loginModel = model;
        [ZCLoginTool sharedLogin].isLogin = NO;
        
        // 存储
        [ZCInfoTool setValue:@"" forKey:UserAccount];
        [ZCInfoTool setValue:@"" forKey:UserPassword];
        
        [MBProgressHUD xe_showSuccess:NSLocalizedString(@"Exit success", nil)];
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [MBProgressHUD xe_showError:error.localizedDescription ?: ZCRequestErrorTip];
    }];
}

@end
