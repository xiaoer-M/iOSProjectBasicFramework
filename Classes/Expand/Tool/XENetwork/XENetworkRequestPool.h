//
//  XENetworkRequestPool.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XENetworkRequestModel;

NS_ASSUME_NONNULL_BEGIN

typedef NSMutableDictionary<NSString *, XENetworkRequestModel *> XECurrentRequestModels;

@interface XENetworkRequestPool : NSObject

/**
 单例

 @return 返回请求池对象
 */
+ (XENetworkRequestPool *_Nonnull)sharedPool;

/**
 请求存放数组

 @return 数组
 */
- (XECurrentRequestModels *_Nonnull)currentRequestModels;

/**
 添加请求类

 @param requestModel 请求类
 */
- (void)addRequestModel:(XENetworkRequestModel *_Nonnull)requestModel;

/**
 删除请求类

 @param requestModel 请求类
 */
- (void)removeRequestModel:(XENetworkRequestModel *_Nonnull)requestModel;

/**
 修改请求类

 @param requestModel 请求类
 @param key 请求标识
 */
- (void)changeRequestModel:(XENetworkRequestModel *_Nonnull)requestModel forKey:(NSString *_Nonnull)key;

/**
 检查是否有剩余的当前请求

 @return 是否有剩余的请求
 */
- (BOOL)remainingCurrentRequests;

/**
 剩余请求个数

 @return 请求个数
 */
- (NSInteger)currentRequestCount;

/**
 打印所有请求信息
 */
- (void)logAllCurrentRequests;



//============================= Cancel requests =============================//

/**
 取消所有请求
 */
- (void)cancelAllCurrentRequests;

/**
 取消地址对应的请求

 @param url 地址
 */
- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url;

/**
 取消多个地址对应的请求

 @param urls 地址数组
 */
- (void)cancelCurrentRequestWithUrls:(NSArray * _Nonnull)urls;

/**
 取消地址、类型、参数对应的请求

 @param url 地址
 @param method 类型
 @param parameters 参数
 */
- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url
                             method:(NSString * _Nonnull)method
                         parameters:(id _Nullable)parameters;



@end

NS_ASSUME_NONNULL_END
