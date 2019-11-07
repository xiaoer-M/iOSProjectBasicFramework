//
//  ZCLoginModel.m
//  i84zcc
//
//  Created by 小二 on 2019/9/12.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCLoginModel.h"

@implementation ZCLoginModel

// 后台有id字段
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId":@"id"};
}


@end    
