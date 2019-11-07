//
//  ZCInfoTool.m
//  i84zcc
//
//  Created by 小二 on 2019/9/16.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCInfoTool.h"

@implementation ZCInfoTool

#pragma mark 获取键值
+ (id)getValueWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

#pragma mark 设置键值
+ (void)setValue:(id)value forKey:(NSString *)key {
    //设置键值
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeValueWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
