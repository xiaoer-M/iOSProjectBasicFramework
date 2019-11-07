//
//  SCUtils.m
//  XEBasisFramework
//
//  Created by 小二 on 2019/8/1.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "SCUtils.h"

@implementation SCUtils

NSString * SCCheckProperty(NSString *property) {
    if (!property || [property isKindOfClass:NSNull.class] || property == nil) {
        return @"";
    }
    return property;
}

NSString * SCStringWithDate(NSString *dateFormat, NSDate *date) {
    if (!dateFormat || !date) {
        return nil;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = dateFormat;
    return [fmt stringFromDate:date];
}

BOOL SCCheckTelNumber(NSString *telNo) {
    if (!telNo || telNo.length != 11) {
        return NO;
    }
    NSMutableString *telString = [[NSMutableString alloc]initWithString:telNo];
    if (![[telString substringToIndex:1] isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}

BOOL SCIsMoreThanFiveMinutes(NSString *time) {
    // 对比时间差
    NSDateComponents *dateCom = P_compareDates([NSDate date], time);
    if (labs(dateCom.year) > 0) {
        return YES;
    }
    else if (labs(dateCom.day) > 0) {
        return YES;
    }
    else if (labs(dateCom.hour) > 0) {
        return YES;
    }
    else if (labs(dateCom.minute) > 5) {
        return YES;
    }
    else
    {
        return NO;
    }
}

BOOL SCIsTheSameDay(NSDate *date) {
    // 对比是否隔天
    NSDateComponents *nowCom = P_getDateComponents([NSDate date]);
    NSDateComponents *otherCom = P_getDateComponents(date);
    
    return nowCom.day == otherCom.day ? YES : NO;
}

// 获取两个时间的时间差
NSDateComponents *P_compareDates(NSDate *date, id another) {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    // 当前时间data格式
    NSDate *nowDate = [date dateByAddingTimeInterval:interval];
    
    // 需要对比的时间
    NSDate *expireDate = nil;
    if ([another isKindOfClass:[NSDate class]]) {
        NSTimeZone *anotherZone = [NSTimeZone systemTimeZone];
        NSInteger anotherInterval = [anotherZone secondsFromGMTForDate:another];
        expireDate = [another dateByAddingTimeInterval:anotherInterval];
    } else {
        //把13位时间戳截取到10位，再加上8小时的时差
        if ([another containsString:@":"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            [dateFormatter setTimeZone:tz];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            expireDate = [dateFormatter dateFromString:another];
        } else {
            expireDate = [NSDate dateWithTimeIntervalSince1970:[[another substringToIndex:10] doubleValue] +3600*8];
        }
    }
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    
    return dateCom;
}

// 获取组成时间对应的时、分、秒
NSDateComponents *P_getDateComponents(NSDate *date) {
    // date8小时时差调整
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *accurateDate = [date dateByAddingTimeInterval:interval];
    
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:accurateDate];
    return comp;
}

NSString *SCBundleVersion(void) {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[@"CFBundleVersion"];
}

BOOL SCIsEmptyString(NSString *target) {
    if (![target isKindOfClass:NSString.class]) {
        // 不是字符串类型, 强转
        target = (NSString *)target;
    }
    if (target == nil
        || target == NULL
        || [target isKindOfClass:NSNull.class]
        || [[target stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

BOOL SCIsEmptyDictonary(NSDictionary *target) {
    if ([target isKindOfClass:NSNull.class] || target == nil) {
        return YES;
    }
    return NO;
}

BOOL SCIsEmptyArray(NSArray *target) {
    if (target == nil || [target isKindOfClass:NSNull.class] || target.count == 0) {
        return YES;
    }
    return NO;
}

NSString *SCNetworkRequestErrorString(NSError *error) {
    static NSDictionary * codeMap = nil;
    if (!codeMap) {
        codeMap = @{
                    @(-1004): @"服务器连接失败",
                    @(-1001): @"请求超时"
                    };
    }
    if (codeMap[@(error.code)]) {
        return codeMap[@(error.code)];
    }
    return error.localizedDescription ? error.localizedDescription : @"请求失败";
}

NSString *SCUIntegerToString(NSUInteger value) {
    return [NSString stringWithFormat:@"%lul", (unsigned long)value];
}

NSString *SCIntegerToString(NSInteger value) {
    return [NSString stringWithFormat:@"%ld", (long)value];
}

void SCSetObject(id Object, NSString * _Nonnull key) {
    [[NSUserDefaults standardUserDefaults] setObject:Object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

id SCObjectForKey(NSString * _Nonnull key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

void SCRemoveObjectForKey(NSString * _Nonnull key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

void SCCallPhone(NSString *number) {
    // 只初始化与一个
    static UIWebView *webView;
    if (!webView) {
        webView = [[UIWebView alloc]init];
    }
    if (!SCCheckTelNumber(number)) {
        return;
    }
    NSString *str = [NSString stringWithFormat:@"tel:%@", number];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:webView];
}

NSString *SCBoolLog(BOOL target) {
    return target ? @"YES" : @"NO";
}

UIViewController *SCSetValue(UIViewController *ctrl, NSDictionary *keyValues) {
    [keyValues enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ctrl setValue:obj forKey:key];
    }];
    return ctrl;
}

CGFloat SCScreenScale(void) {
    __block CGFloat _scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _scale = [UIScreen mainScreen].scale;
    });
    return _scale;
}

void SCDelayExec(dispatch_queue_t queue, NSTimeInterval interval, DelayExecCallback callback) {
    if (interval < 0 || !callback) {
        return;
    }
    if (!queue) {
        queue = dispatch_get_main_queue();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), queue, ^{
        !callback?:callback();
    });
}

BOOL SCMapCanOpenURL(NSString *urlString) {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
}

NSDictionary * SCBaiDuTransformGaoDe(NSString *lat, NSString *lng) {
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    
    double _lng = [lng doubleValue];
    double _lat = [lat doubleValue];
    
    
    double x = _lng - 0.0065;
    double y = _lat - 0.006;
    
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double lngs = z * cos(theta);
    double lats = z * sin(theta);
    
    return @{@"lng": @(lngs), @"lat":@(lats)};
}


@end
