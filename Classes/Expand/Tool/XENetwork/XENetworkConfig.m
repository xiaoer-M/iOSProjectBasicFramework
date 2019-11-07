//
//  XENetworkConfig.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkConfig.h"

@implementation XENetworkConfig

+ (XENetworkConfig *)sharedConfig {
    static XENetworkConfig *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        shareInstance.timeoutInterval = 15; 
    });
    return shareInstance;
}

- (void)addCustomHeader:(NSDictionary *)header {
    if (![header isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([header allKeys].count == 0) {
        return;
    }
    
    if (!_customHeaders) {
        _customHeaders = header;
        return;
    }
    
    NSMutableDictionary *myHeader = [_customHeaders mutableCopy];
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [myHeader setObject:obj forKey:key];
    }];
    _customHeaders = [myHeader copy];
}

@end
