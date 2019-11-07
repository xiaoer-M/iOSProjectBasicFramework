//
//  XECheckUpdateTool.m
//  i84zcc
//
//  Created by 小二 on 2019/9/18.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XECheckUpdateTool.h"
#import "XECheckUpdateView.h"

@implementation XECheckUpdateTool

+ (void)cheackUpdate {
    NSDictionary *params = @{@"action": ZCRequest_GetVersion, @"type": @"2", @"projectId": @"1"};
    
    [[XENetworkManager sharedManager] sendPostRequest:ZCRequest_Api parameters:params success:^(id responseObject) {
        NSInteger responseCode = [responseObject[@"_code"] integerValue];
        if (responseCode != 99999) {
            return;
        }
        
        NSDictionary *result = responseObject[@"_result"];
        if (SCIsEmptyDictonary(result)) {
            return;
        }
        
        [self compareCode:[result[@"code"] integerValue] url:result[@"url"] version:result[@"version"]];
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        
    }];
}

+ (void)compareCode:(NSUInteger)code url:(NSString *)url version:(NSString *)version {
    NSString *localCode = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if (code > [localCode integerValue]) {
        XECheckUpdateView *updateView = [[XECheckUpdateView alloc] init];
        [updateView reloadUpdateViewWithVersion:version];
        
        updateView.updateBlock = ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        };
        [[UIApplication sharedApplication].delegate.window addSubview:updateView];
    }
}

@end
