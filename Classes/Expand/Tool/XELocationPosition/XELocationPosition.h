//
//  XELocationPosition.h
//  i84zcc
//
//  Created by 小二 on 2019/9/29.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 地图数据对象
 */
@interface Location : NSObject
///国家
@property (nonatomic, copy) NSString * country;
///省 直辖市
@property (nonatomic, copy) NSString * administrativeArea;
///地级市 直辖市区
@property (nonatomic, copy) NSString * locality;
///县 区
@property (nonatomic, copy) NSString * subLocality;
///街道
@property (nonatomic, copy) NSString * thoroughfare;
///子街道
@property (nonatomic, copy) NSString * subThoroughfare;
///经度
@property (nonatomic, assign) CLLocationDegrees longitude;
///纬度
@property (nonatomic, assign) CLLocationDegrees latitude;

@end

@protocol XELocationPositionDelegate <NSObject>
///定位数据回调
- (void)locationDidEndUpdatingLocation:(Location *)location;

@optional
///不允许定位回调
- (void)locationDenied;
///定位失败回调
- (void)locationDidFail:(Location *)location;

@end

@interface XELocationPosition : NSObject
@property (nonatomic, weak) id<XELocationPositionDelegate> delegate;

///开始定位
- (void)beginUpdatingLocation;

@end

NS_ASSUME_NONNULL_END

