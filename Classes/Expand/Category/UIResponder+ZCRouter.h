//
//  UIResponder+ZCRouter.h
//  i84zcc
//
//  Created by 小二 on 2020/3/30.
//  Copyright © 2020 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (ZCRouter)

/**
 发送一个路由器消息, 对eventName感兴趣的 UIResponsder 可以对消息进行处理
 
 @param eventName 发生的事件名称
 @param userInfo 传递消息时, 携带的数据, 数据传递过程中, 会有新的数据添加
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject * _Nullable)userInfo;

@end

NS_ASSUME_NONNULL_END
