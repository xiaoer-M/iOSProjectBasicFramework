//
//  UIResponder+ZCRouter.m
//  i84zcc
//
//  Created by 小二 on 2020/3/30.
//  Copyright © 2020 小二. All rights reserved.
//

#import "UIResponder+ZCRouter.h"

@implementation UIResponder (ZCRouter)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject * _Nullable)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
