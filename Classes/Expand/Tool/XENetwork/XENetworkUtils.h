//
//  XENetworkUtils.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XENetworkUtils : NSObject

// 获取app版本号
+ (NSString * _Nullable)appVersionStr;

// 对字符串进行MD5加密
+ (NSString * _Nonnull)generateMD5StringFromString:(NSString *_Nonnull)string;

+ (NSString *_Nonnull)generateCompleteRequestUrlStrWithBaseUrlStr:(NSString *_Nonnull)baseUrlStr
                                                    requestUrlStr:(NSString *_Nonnull)requestUrlStr;

+ (NSString *_Nonnull)generateRequestIdentiferWithBaseUrlStr:(NSString * _Nullable)baseUrlStr
                                               requestUrlStr:(NSString * _Nullable)requestUrlStr
                                                   methodStr:(NSString * _Nullable)methodStr
                                                  parameters:(id _Nullable)parameters;



/**
 通过requestIdentifer获取缓存数据文件路径

 @param requestIdentifer 请求标识
 @return 路径
 */
+ (NSString * _Nonnull)cacheDataFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer;

/**
 通过requestIdentifer获取缓存数据文件路径

 @param requestIdentifer 请求标识
 @return 路径
 */
+ (NSString * _Nonnull)cacheDataInfoFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer;

/**
 恢复数据文件路径

 @param requestIdentifer 请求标识
 @param downloadFileName 下载文件名
 @return 路径
 */
+ (NSString * _Nonnull)resumeDataFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer downloadFileName:(NSString * _Nonnull)downloadFileName;

/**
 回复数据文件路径

 @param requestIdentifer 标识
 @return 路径
 */
+ (NSString * _Nonnull)resumeDataInfoFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer;

/**
 数据是否可用

 @param data 数据
 @return 是否
 */
+ (BOOL)availabilityOfData:(NSData * _Nonnull)data;

/**
 图片数据转化字符串

 @param imageData 图片数据
 @return 字符串
 */
+ (NSString * _Nullable)imageFileTypeForImageData:(NSData * _Nonnull)imageData;


/**
 处理请求成功的返回结果（包括成功和失败的结果）

 @param responseObjec 数据
 @return 字典/数组/BOOL
 */
+ (id _Nullable)handleRequestSuccessResult:(id)responseObjec;

/**
 处理请求错误的error

 @param error 错误类
 */
+ (void)handleRequestError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
