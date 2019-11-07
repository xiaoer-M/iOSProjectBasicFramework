//
//  ZCUserModel.h
//  i84zcc
//
//  Created by 小二 on 2019/9/23.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCUserModel : NSObject
/// 真实姓名
@property (nonatomic, copy) NSString *realName;
/// 用户名
@property (nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
