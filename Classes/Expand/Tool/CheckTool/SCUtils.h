//
//  SCUtils.h
//  XEBasisFramework
//
//  Created by 小二 on 2019/8/1.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCUtils : NSObject

/**
 检查属性，null替换为---
 
 @param property 属性的值
 @return 原值或者---
 */
UIKIT_EXTERN NSString * SCCheckProperty(NSString *property);

/**
 日期转为自定格式的字符串
 
 @param dateFormat 自定义格式
 @param date 转换日期
 @return 转换后的字符串
 */
UIKIT_EXTERN NSString * SCStringWithDate(NSString *dateFormat, NSDate *date);


/**
 校验手机号码
 
 @param telNo 手机号
 @return YES 是 NO  不是
 */
UIKIT_EXTERN BOOL SCCheckTelNumber(NSString *telNo);

/**
对比服务器时间与本地时间差距是否超过5分钟

@return 回调
*/
UIKIT_EXTERN BOOL SCIsMoreThanFiveMinutes(NSString *time);

/*
对比服务器时间与本地时间是否为同一天
*/
UIKIT_EXTERN BOOL SCIsTheSameDay(NSDate *date);

/**
 判断字符串是否为空
 
 @param target 字符串
 @return YES 为空 NO 不为空
 */
UIKIT_EXTERN BOOL SCIsEmptyString(NSString *target);


/**
 判断字典是否为空
 
 @param target 字典
 @return YES 为空 NO 不为空
 */
UIKIT_EXTERN BOOL SCIsEmptyDictonary(NSDictionary *target);


/**
 判断数组是否为空
 
 @param target 数组
 @return YES 为空NO 不为空
 */
UIKIT_EXTERN BOOL SCIsEmptyArray(NSArray *target);


/**
 网络请求失败转中文提示
 
 @param error 错误信息
 @return 错误提示
 */
UIKIT_EXTERN NSString * SCNetworkRequestErrorString(NSError *error);


/**
 拨打点话
 
 @param number 电话号码
 */
UIKIT_EXTERN void SCCallPhone(NSString *number);

/**
 NSUserdefault使用
 
 @param Object 对象
 @param key  key
 */
UIKIT_EXTERN void SCSetObject(id Object, NSString * _Nonnull key);

UIKIT_EXTERN id SCObjectForKey(NSString * _Nonnull key);

UIKIT_EXTERN void SCRemoveObjectForKey(NSString * _Nonnull key);


/**
 整型转字符串
 
 @param value 整型
 @return 字符串
 */
UIKIT_EXTERN NSString *SCUIntegerToString(NSUInteger value);

UIKIT_EXTERN NSString *SCIntegerToString(NSInteger value);

/**
 获取build
 
 @return build值
 */
UIKIT_EXTERN NSString *SCBundleVersion(void);

/**
 输出布尔类型
 
 @param target 值
 @return YE NO
 */
UIKIT_EXTERN NSString *SCBoolLog(BOOL target);

UIKIT_EXTERN UIViewController *SCSetValue(UIViewController *ctrl, NSDictionary *keyValues);


/**
 获取屏幕的scale
 
 @return scale
 */
UIKIT_EXTERN CGFloat SCScreenScale(void);


typedef void(^DelayExecCallback)(void);
/**
 在制定队列上延迟执行
 
 @param callback 回调
 @param interval 延迟时间
 @param queue 队列
 */
UIKIT_EXTERN void SCDelayExec(dispatch_queue_t queue, NSTimeInterval interval, DelayExecCallback callback);

/**
 判断某地图是否可以打开
 */
UIKIT_EXTERN BOOL SCMapCanOpenURL(NSString *urlString);

/**
 百度地图经纬度转高德
 */
UIKIT_EXTERN NSDictionary * SCBaiDuTransformGaoDe(NSString *lat, NSString *lng);

@end

NS_ASSUME_NONNULL_END
