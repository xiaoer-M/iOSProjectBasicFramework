//
//  XENetworkUtils.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkUtils.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const XENetworkCacheBaseFolderName = @"XENetworkCache";
NSString * const XENetworkCacheFileSuffix = @"cacheData";
NSString * const XENetworkCacheInfoFileSuffix = @"cacheInfo";
NSString * const XENetworkDownloadResumeDataInfoFileSuffix = @"resumeInfo";

typedef NS_ENUM(NSInteger, ErrCode) {
    ErrCodeRequestOutTime = 1001    // 请求超时
};//请求错误枚举

typedef NS_ENUM(NSInteger, RequestResultCode) {
    RequestResultCodeSucceeded = 99999,
    RequestResultCodeNoLogin = 20001
};//请求结果枚举

@implementation XENetworkUtils

#pragma mark - ============ Public Methods =============
+ (NSString * _Nullable)appVersionStr{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


+ (NSString * _Nonnull)generateMD5StringFromString:(NSString * _Nonnull)string {
    
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}


+ (NSString * _Nonnull)generateCompleteRequestUrlStrWithBaseUrlStr:(NSString * _Nonnull)baseUrlStr requestUrlStr:(NSString * _Nonnull)requestUrlStr{
    
    NSURL *requestUrl = [NSURL URLWithString:requestUrlStr];
    
    if (requestUrl && requestUrl.host && requestUrl.scheme) {
        return requestUrlStr;
    }
    
    NSURL *url = [NSURL URLWithString:baseUrlStr];
    
    if (baseUrlStr.length > 0 && ![baseUrlStr hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    return [NSURL URLWithString:requestUrlStr relativeToURL:url].absoluteString;
    
}

+ (NSString * _Nonnull)generateRequestIdentiferWithBaseUrlStr:(NSString * _Nullable)baseUrlStr
                                                requestUrlStr:(NSString * _Nullable)requestUrlStr
                                                    methodStr:(NSString * _Nullable)methodStr
                                                   parameters:(id _Nullable)parameters{
    
    NSString *host_md5 =         [self generateMD5StringFromString: [NSString stringWithFormat:@"Host:%@",baseUrlStr]];
    NSString *url_md5 =          [self generateMD5StringFromString: [NSString stringWithFormat:@"Url:%@",requestUrlStr]];
    NSString *method_md5 =       [self generateMD5StringFromString: [NSString stringWithFormat:@"Method:%@",methodStr]];
    
    NSString *paramsStr = @"";
    NSString *parameters_md5 = @"";
    
    if (parameters) {
        paramsStr =        [self p_convertJsonStringFromDictionaryOrArray:parameters];
        parameters_md5 =   [self generateMD5StringFromString: [NSString stringWithFormat:@"Parameters:%@",paramsStr]];
    }
    
    NSString *requestIdentifer = [NSString stringWithFormat:@"%@_%@_%@_%@",host_md5,url_md5,method_md5,parameters_md5];
    
    return requestIdentifer;
    
}

+ (NSString * _Nonnull)cacheDataFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer {
    if (requestIdentifer.length > 0) {
        
        NSString *cacheFileName = [NSString stringWithFormat:@"%@.%@", requestIdentifer,XENetworkCacheFileSuffix];
        NSString *cacheFilePath = [[self createCacheBasePath] stringByAppendingPathComponent:cacheFileName];
        return cacheFilePath;
        
    }else{
        return @"";
    }
}

+ (NSString * _Nonnull)cacheDataInfoFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer {
    
    if (requestIdentifer.length > 0) {
        
        NSString *cacheInfoFileName = [NSString stringWithFormat:@"%@.%@", requestIdentifer,XENetworkCacheInfoFileSuffix];
        NSString *cacheInfoFilePath = [[self createCacheBasePath] stringByAppendingPathComponent:cacheInfoFileName];
        return cacheInfoFilePath;
        
    }else{
        return @"";
    }
}

+ (NSString * _Nonnull)resumeDataFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer downloadFileName:(NSString * _Nonnull)downloadFileName{
    
    NSString *dataFileName = [NSString stringWithFormat:@"%@.%@", requestIdentifer, downloadFileName];
    NSString * resumeDataFilePath = [[self createCacheBasePath] stringByAppendingPathComponent:dataFileName];
    return resumeDataFilePath;
}

+ (NSString * _Nonnull)resumeDataInfoFilePathWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer {
    NSString * dataInfoFileName = [NSString stringWithFormat:@"%@.%@", requestIdentifer,XENetworkDownloadResumeDataInfoFileSuffix];
    NSString * resumeDataInfoFilePath = [[self createCacheBasePath] stringByAppendingPathComponent:dataInfoFileName];
    return resumeDataInfoFilePath;
}

+ (BOOL)availabilityOfData:(NSData * _Nonnull)data {
    if (!data || [data length] < 1) return NO;
    
    NSError *error;
    NSDictionary *resumeDictionary = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
    
    if (!resumeDictionary || error) return NO;
    
    // Before iOS 9 & Mac OS X 10.11
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED < 90000)\
|| (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED < 101100)
    NSString *localFilePath = [resumeDictionary objectForKey:@"NSURLSessionResumeInfoLocalPath"];
    if ([localFilePath length] < 1) return NO;
    return [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
#endif
    return YES;
}

+ (NSString * _Nullable)imageFileTypeForImageData:(NSData * _Nonnull)imageData {
    uint8_t c;
    [imageData getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([imageData length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[imageData subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}


+ (id _Nullable)handleRequestSuccessResult:(id)responseObjec {
    RequestResultCode errCode = [responseObjec[@"_code"] integerValue];
    
    id resultDic = nil;
    BOOL isSuccessed = NO;
    switch (errCode) {
        case RequestResultCodeSucceeded: {
            isSuccessed = YES;
            resultDic = responseObjec[@"_result"];
            break;
        }
        case RequestResultCodeNoLogin: {
            [[self p_getCurrentVC] presentLoginViewController];
            break;
        }
        default: {
            if (!SCIsEmptyString(responseObjec[@"_msg"])) {
                [MBProgressHUD xe_showError:responseObjec[@"_msg"]];
            } else {
                [MBProgressHUD xe_showError:ZCRequestErrorTip];
            }
            break;
        }
    }
    
    /*
     外面会用正确的类型接收_result，但是存在没有_result字段和失败的情况
     1.没有_result的情况：例如添加和删除线路接口，只有成功失败，所以添加一个BOOL处理
     2.失败的情况：例如线路列表接口，是用Array接收，但是请求失败的话就会返回字典造成崩溃，所以请求失败的话返回nil
     */
    if ([[responseObjec allKeys] containsObject:@"_result"]) {
        if (resultDic != nil) {
            return resultDic;
        }
    }
    
    if (isSuccessed) {
       return [NSNumber numberWithBool:isSuccessed];
    }
    
    return nil;
}

+ (void)handleRequestError:(NSError *)error {
    
}

#pragma mark - ============ Private Methods =============
///获取当前控制器
+ (UIViewController *)p_getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

+ (NSString *)p_convertJsonStringFromDictionaryOrArray:(id)parameter {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameter
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (NSString * _Nonnull)createCacheBasePath {
    return [self createBasePathWithFolderName:XENetworkCacheBaseFolderName];
}

+ (NSString * _Nonnull)createBasePathWithFolderName:(NSString * _Nonnull)folderName {
    NSString *pathOfCache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfCache stringByAppendingPathComponent:folderName];
    [self p_createDirectoryIfNeeded:path];
    return path;
}

+ (void)p_createDirectoryIfNeeded:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        
        [self p_createBaseDirectoryAtPath:path];
        
    } else {
        
        if (!isDir) {
            
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self p_createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)p_createBaseDirectoryAtPath:(NSString *)path {
    
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
}



@end
