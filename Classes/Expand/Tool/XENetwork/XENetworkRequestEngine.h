//
//  XENetworkRequestEngine.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENetworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface XENetworkRequestEngine : NSObject

/**
 发送请求

 @param url 请求url
 @param method 方式
 @param params 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)sendRequest:(NSString *_Nonnull)url
             method:(XERequestMethod)method
             params:(id _Nullable)params
            success:(XESuccessBlock _Nullable)successBlock
            failure:(XEFailureBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
