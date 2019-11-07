//
//  XENetworkRequestModel.h
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENetworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface XENetworkRequestModel : NSObject
// 请求标识
@property (nonatomic, readwrite, copy) NSString *requestIdentifer;
// 请求任务（这里也可以是上传下载）
@property (nonatomic, readwrite, strong) NSURLSessionTask *task;
// 响应
@property (nonatomic, readwrite, strong) NSURLResponse *response;
// 请求url
@property (nonatomic, readwrite, copy) NSString *requestUrl;
// 请求方式
@property (nonatomic, readwrite, copy) NSString *method;
// 返回对象
@property (nonatomic, readwrite, strong) id responseObject;

// ================= 请求参数 =================
@property (nonatomic, readwrite, strong) id params;  //请求参数
@property (nonatomic, readwrite, strong) NSData *responseData; //请求回调
@property (nonatomic, readwrite, copy) XESuccessBlock successBlock;
@property (nonatomic, readwrite, copy) XEFailureBlock failureBlock;



// ================= 上传参数 =================
@property (nonatomic, readwrite, copy)   NSString *uploadUrl;                        //上传url
@property (nonatomic, readwrite, copy)   NSArray<UIImage *> *uploadImages;           //上传的图片数组
@property (nonatomic, readwrite, copy)   NSString *imagesIdentifer;                  //上传图片b标识
@property (nonatomic, readwrite, copy)   NSString *mimeType;                         //上传文件类型
@property (nonatomic, readwrite, assign) float imageCompressRatio;                   //compress ratio of all upload images, default is 1(original)

@property (nonatomic, readwrite, copy) XEUploadSuccessBlock uploadSuccessBlock;
@property (nonatomic, readwrite, copy) XEUploadProgressBlock uploadProgressBlock;
@property (nonatomic, readwrite, copy) XEUploadFailureBlock uploadFailedBlock;


// ================= 下载参数 =================
@property (nonatomic, readwrite, copy)   NSString *downloadFilePath;                  // 下载文件路径
@property (nonatomic, readwrite, assign) BOOL resumableDownload;                      // 是否支持恢复下载
@property (nonatomic, readwrite, assign) BOOL backgroundDownloadSupport;              // 是否支持后台下载
@property (nonatomic, readwrite, strong) NSOutputStream *stream;                      // 保存下载数据流
@property (nonatomic, readwrite, assign) NSInteger totalLength;                       // 下载文件总长度
@property (nonatomic, readonly, copy)    NSString *resumeDataFilePath;                // 恢复数据文件路径
@property (nonatomic, readonly, copy)    NSString *resumeDataInfoFilePath;            // 恢复数据信息文件路径
@property (nonatomic, readwrite, assign) XEDownloadManualOperation manualOperation;   // 按用户要求操作
@property (nonatomic, readwrite, copy)   XEDownloadSuccessBlock downloadSuccessBlock;
@property (nonatomic, readwrite, copy)   XEDownloadProgressBlock downloadProgressBlock;
@property (nonatomic, readwrite, copy)   XEDownloadFailureBlock downloadFailureBlock;

/**
 请求类型

 @return type
 */
- (XERequestType)requestType;

/**
 缓存数据文件的文件路径

 @return path
 */
- (NSString *)cacheDataFilePath;

/**
 缓存信息数据文件的文件路径

 @return path
 */
- (NSString *)cacheDataInfoFilePath;

/**
 下载的数据文件路径

 @return path
 */
- (NSString *)resumeDataFilePath;

/**
 下载的数据信息文件路径

 @return path
 */
- (NSString *)resumeDataInfoFilePath;

/**
 清除所有block
 */
- (void)clearAllBlocks;

@end

NS_ASSUME_NONNULL_END
