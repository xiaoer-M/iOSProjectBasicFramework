//
//  XENetworkHeader.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#ifndef XENetworkHeader_h
#define XENetworkHeader_h

#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG
#define XELog(...) NSLog(@"%s line number:%d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define XELog(...)
#endif

// *************** 请求回调 ************* //
typedef void(^XESuccessBlock)(id responseObject);
typedef void(^XEFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode);
typedef void(^XEErrorBlock)(NSError *error);

// *************** 上传回调 ************* //
typedef void(^XEUploadSuccessBlock)(id responseObject);
typedef void(^XEUploadProgressBlock)(NSProgress *uploadProgress);
typedef void(^XEUploadFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode, NSArray<UIImage *>*uploadFailedImages);

// *************** 下载回调 ************* //
typedef void(^XEDownloadSuccessBlock)(id responseObject);
typedef void(^XEDownloadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);
typedef void(^XEDownloadFailureBlock)(NSURLSessionTask *task, NSError *error, NSString* resumableDataPath);

typedef NS_ENUM(NSUInteger, XERequestMethod) {
    XERequestMethodGET = 60000,
    XERequestMethodPOST,
    XERequestMethodPUT,
    XERequestMethodDELETE
};

typedef NS_ENUM(NSInteger, XERequestType) {
    XERequestTypeOrdinary = 70000,
    XERequestTypeUpload,
    XERequestTypeDownload
};

typedef NS_ENUM(NSInteger, XEDownloadManualOperation) {
    XEDownloadManualOperationStart = 80000,
    XEDownloadManualOperationSuspend,
    XEDownloadManualOperationResume,
    XEDownloadManualOperationCancel,
};

#endif /* XENetworkHeader_h */
