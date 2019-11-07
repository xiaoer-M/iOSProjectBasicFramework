//
//  ZCConst.m
//  i84zcc
//
//  Created by 小二 on 2019/9/12.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCConst.h"

@implementation ZCConst

#pragma mark - 通知
NSString * const ZCNotification_LoginSuccess = @"ZCNotification_LoginSuccess";
NSString * const ZCNotification_GetUserInfo = @"ZCNotification_GetUserInfo";
NSString * const ZCNotification_OutLogin = @"ZCNotification_OutLogin";



#pragma mark - 接口名
NSString * const ZCRequest_Api = @"api";
NSString * const ZCRequest_Login = @"login";
NSString * const ZCRequest_Logout = @"userLogout";
NSString * const ZCRequest_MyLineList = @"zgy_line_list";
NSString * const ZCRequest_AddLine = @"add_zgy_line";
NSString * const ZCRequest_DelLine = @"del_zgy_line";
NSString * const ZCRequest_GetVersion = @"app_version";
NSString * const ZCRequest_ChangePassword = @"edit_zgy_password";
NSString * const ZCRequest_PersonInfo = @"get_zgy_person_info";
NSString * const ZCRequest_CallInfo = @"get_line_call_info";
NSString * const ZCRequest_SubmitCall = @"call_station";
NSString * const ZCRequest_LineReset = @"line_reset";
NSString * const ZCRequest_ReplaceBus = @"zgy_change_bus";
NSString * const ZCRequest_CurrentTime = @"get_current_time";
NSString * const ZCRequest_MyParent = @"my_parent";




@end
