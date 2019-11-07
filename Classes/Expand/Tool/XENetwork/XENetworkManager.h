//
//  XENetworkManager.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENetworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class XENetworkHeader;

@interface XENetworkManager : NSObject

/**
 单例

 @return 管理类
 */
+ (XENetworkManager *_Nullable)sharedManager;


/**
 *  禁止使用new方法初始化
 */
+ (instancetype _Nullable)new NS_UNAVAILABLE;

/**
 添加自定义请求头

 @param header 请求头
 */
- (void)addCustomHeader:(NSDictionary *_Nonnull)header;


/**
 自定义请求头

 @return 请求头
 */
- (NSDictionary *_Nullable)customHeaders;


#pragma mark- Request API using POST method

/**
 GET请求

 @param url 请求地址
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
               success:(XESuccessBlock _Nullable)successBlock
               failure:(XEFailureBlock _Nullable)failureBlock;



/**
 GET请求(带参数)

 @param url 请求地址
 @param parameters 请求参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(XESuccessBlock _Nullable)successBlock
               failure:(XEFailureBlock _Nullable)failureBlock;


#pragma mark- Request API using POST method

/**
 POST请求

 @param url 请求地址
 @param parameters 请求参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
                success:(XESuccessBlock _Nullable)successBlock
                failure:(XEFailureBlock _Nullable)failureBlock;


@end

NS_ASSUME_NONNULL_END
