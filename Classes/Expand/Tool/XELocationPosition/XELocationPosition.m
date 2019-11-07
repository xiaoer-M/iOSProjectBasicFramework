//
//  XELocationPosition.m
//  i84zcc
//
//  Created by 小二 on 2019/9/29.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XELocationPosition.h"

@interface XELocationPosition()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager * locationManager;
// 定位只取一次数据
@property (nonatomic, assign) BOOL onlyOne;

@end

@implementation XELocationPosition

- (void)beginUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

#pragma mark - location delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //获取新的位置
    CLLocation * newLocation = locations.lastObject;
    //创建自定制位置对象
    Location * location = [[Location alloc] init];
    //存储经度
    location.longitude = newLocation.coordinate.longitude;
    //存储纬度
    location.latitude = newLocation.coordinate.latitude;
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark * placemark = placemarks.firstObject;
            //存储位置信息
            location.country = placemark.country;
            location.administrativeArea = placemark.administrativeArea;
            location.locality = placemark.locality;
            location.subLocality = placemark.subLocality;
            location.thoroughfare = placemark.thoroughfare;
            location.subThoroughfare = placemark.subThoroughfare;
            
            //设置代理方法
            if (self.onlyOne) {
                return;
            }
            
            self.onlyOne = YES;
            
            if ([self.delegate respondsToSelector:@selector(locationDidEndUpdatingLocation:)]) {
                [self.delegate locationDidEndUpdatingLocation:location];
            }
            
        }
        
        if (error) {
            if ([self.delegate respondsToSelector:@selector(locationDidFail:)]) {
                [self.delegate locationDidFail:location];
            }
        }
    }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    //不允许
    if (status == kCLAuthorizationStatusDenied) {
        if ([self.delegate respondsToSelector:@selector(locationDenied)]) {
            [self.delegate locationDenied];
        }
    }
}

#pragma mark - getter/setter
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        // 设置定位精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是 requestAlwaysAuthorization
        // 一个是 requestWhenInUseAuthorization
        [_locationManager requestWhenInUseAuthorization];//ios8以上版本使用。
        [_locationManager requestAlwaysAuthorization];
    }
    return _locationManager;
}

@end

@implementation Location

@end
