//
//  ZCInfoTool.h
//  i84zcc
//
//  Created by 小二 on 2019/9/16.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 版本
static NSString *AppVersion = @"AppVersion";
// 账号
static NSString *UserAccount = @"UserAccount";
// 密码
static NSString *UserPassword = @"UserPassword";


@interface ZCInfoTool : NSObject

/****************************************************************************************
 *InfoTool说明（使用NSUserDefaults存储OC对象）
 *1、这里只可以储存需要长期储存的数据
 *2、不可储存临时变量
 *3、储存的键值在这里创建变量KEY，不可滥用
 ****************************************************************************************/


///获取数据
+ (id)getValueWithKey:(NSString *)key;
///存储数据
+ (void)setValue:(id)value forKey:(NSString *)key;
///删除数据
+ (void)removeValueWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
