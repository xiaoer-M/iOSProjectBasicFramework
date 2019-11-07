
//
//  XENetworkConfig.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XENetworkConfig : NSObject
// 基础url
@property (nonatomic, strong) NSString *_Nullable baseUrl;
// 默认参数，default is nil
@property (nonatomic, strong) NSDictionary *_Nullable defaultParams;
// 自定义请求头，default is nil
@property (nonatomic, strong) NSDictionary *_Nullable customHeaders;
// 请求超时时间，default is 20
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
// 是否打印日志
@property (nonatomic, assign) BOOL debugLog;

/**
 单例

 @return 初始化的XENetworkConfig
 */
+ (XENetworkConfig *_Nullable)sharedConfig;

/**
 添加请求头

 @param header 自定义的请求头数据
 */
- (void)addCustomHeader:(NSDictionary *_Nullable)header;

@end

NS_ASSUME_NONNULL_END
