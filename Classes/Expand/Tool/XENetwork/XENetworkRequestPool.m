//
//  XENetworkRequestPool.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkRequestPool.h"
#import "XENetworkConfig.h"
#import "XENetworkRequestModel.h"
#import "XENetworkUtils.h"

#import <pthread/pthread.h>
#import "objc/runtime.h"

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

static char currentRequestModelsKey;

@interface XENetworkRequestPool ()
@property (nonatomic, assign) BOOL isDebugLog;
@property (nonatomic, assign) pthread_mutex_t lock;

@end

@implementation XENetworkRequestPool

+ (XENetworkRequestPool *_Nonnull)sharedPool {
    static XENetworkRequestPool *sharedPool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPool = [[XENetworkRequestPool alloc] init];
    });
    return sharedPool;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //lock
        pthread_mutex_init(&_lock, NULL);
        
        //debug mode or not
        _isDebugLog = [[XENetworkConfig sharedConfig] debugLog];
        
    }
    return self;
}


- (XECurrentRequestModels *_Nonnull)currentRequestModels {
    XECurrentRequestModels *currentRequestModels = objc_getAssociatedObject(self, &currentRequestModelsKey);
    if (currentRequestModels) {
        return currentRequestModels;
    }
    currentRequestModels = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &currentRequestModelsKey, currentRequestModels, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return currentRequestModels;
}

- (void)addRequestModel:(XENetworkRequestModel *_Nonnull)requestModel {
    Lock();
    [self.currentRequestModels setObject:requestModel forKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
}

- (void)removeRequestModel:(XENetworkRequestModel *_Nonnull)requestModel {
    Lock();
    [self.currentRequestModels removeObjectForKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
}

- (void)changeRequestModel:(XENetworkRequestModel *_Nonnull)requestModel forKey:(NSString *_Nonnull)key {
    Lock();
    [self.currentRequestModels removeObjectForKey:key];
    [self.currentRequestModels setObject:requestModel forKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
}

- (BOOL)remainingCurrentRequests {
    NSArray *keys = [self.currentRequestModels allKeys];
    if (keys.count > 0) {
        XELog(@"=========== There is remaining current request");
        return YES;
    }
    XELog(@"=========== There is no remaining current request");
    return NO;
}


- (NSInteger)currentRequestCount {
    if (![self remainingCurrentRequests]) {
        return 0;
    }
    
    return [self.currentRequestModels allKeys].count;
}

- (void)logAllCurrentRequests {
    if ([self remainingCurrentRequests]) {
        [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XENetworkRequestModel * _Nonnull obj, BOOL * _Nonnull stop) {
            XELog(@"============ Log current request:\n %@",obj);
        }];
    }
}


- (void)cancelAllCurrentRequests {
    if ([self remainingCurrentRequests]) {
        [self.currentRequestModels.allValues enumerateObjectsUsingBlock:^(XENetworkRequestModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.requestType == XERequestTypeDownload) {
                if (obj.backgroundDownloadSupport) {
                    NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask*)obj.task;
                    [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                    }];
                } else {
                    [obj.task cancel];
                }
            } else {
                [obj.task cancel];
                [self removeRequestModel:obj];
            }
        }];
        
        XELog(@"=========== Canceled call current requests");
    }
}


- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url {
    if (![self remainingCurrentRequests]) {
        return;
    }
    
    NSMutableArray *cancelRequestModelsArr = [NSMutableArray arrayWithCapacity:2];
    NSString *requestIdentiferOfUrl =  [XENetworkUtils generateMD5StringFromString: [NSString stringWithFormat:@"Url:%@",url]];
    
    [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XENetworkRequestModel * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.requestIdentifer containsString:requestIdentiferOfUrl]) {
            [cancelRequestModelsArr addObject:obj];
        }
    }];
    
    
    if ([cancelRequestModelsArr count] == 0) {
        XELog(@"=========== There is no request to be canceled");
    } else {
        if (_isDebugLog) {
            XELog(@"=========== Requests to be canceled:");
            [cancelRequestModelsArr enumerateObjectsUsingBlock:^(XENetworkRequestModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XELog(@"=========== cancel request with url[%ld]:%@",(unsigned long)idx,obj.requestUrl);
            }];
        }
        
        [cancelRequestModelsArr enumerateObjectsUsingBlock:^(XENetworkRequestModel * _Nonnull requestModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (requestModel.requestType == XERequestTypeDownload) {

                if (requestModel.backgroundDownloadSupport) {
                    NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask*)requestModel.task;
                    
                    if (requestModel.task.state == NSURLSessionTaskStateCompleted) {
                        XELog(@"=========== Canceled background support download request:%@",requestModel);
                        NSError *error = [NSError errorWithDomain:@"Request has been canceled" code:0 userInfo:nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (requestModel.downloadFailureBlock) {
                                requestModel.downloadFailureBlock(requestModel.task, error,requestModel.resumeDataFilePath);
                            }
                            [self handleRequesFinished:requestModel];
                        });
                        
                    } else {
                        
                        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                        }];
                        XELog(@"=========== Background support download request %@ has been canceled",requestModel);
                    }
                    
                } else {
                    
                    [requestModel.task cancel];
                    XELog(@"=========== Request %@ has been canceled",requestModel);
                }
                
            } else {
                
                [requestModel.task cancel];
                XELog(@"=========== Request %@ has been canceled",requestModel);
                if (requestModel.requestType != XERequestTypeDownload) {
                    [self removeRequestModel:requestModel];
                }
            }
        }];
        
        XELog(@"=========== All requests with request url : '%@' are canceled",url);
    }
}


- (void)cancelCurrentRequestWithUrls:(NSArray * _Nonnull)urls {
    if ([urls count] == 0) {
        XELog(@"=========== There is no input urls!");
        return;
    }
    
    if(![self remainingCurrentRequests]){
        return;
    }
    
    [urls enumerateObjectsUsingBlock:^(NSString *url, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cancelCurrentRequestWithUrl:url];
    }];
}


- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url
                             method:(NSString * _Nonnull)method
                         parameters:(id _Nullable)parameters {
    if(![self remainingCurrentRequests]){
        return;
    }
    
    NSString *requestIdentifier = [XENetworkUtils generateRequestIdentiferWithBaseUrlStr:[XENetworkConfig sharedConfig].baseUrl
                                                                           requestUrlStr:url
                                                                               methodStr:method
                                                                              parameters:parameters];
    
    [self p_cancelRequestWithRequestIdentifier:requestIdentifier];
}

- (void)p_cancelRequestWithRequestIdentifier:(NSString *)requestIdentifier{
    
    [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XENetworkRequestModel * _Nonnull requestModel, BOOL * _Nonnull stop) {
        
        if ([requestModel.requestIdentifer isEqualToString:requestIdentifier]) {
            
            if (requestModel.task) {
                
                [requestModel.task cancel];
                XELog(@"=========== Canceled request:%@",requestModel);
                if (requestModel.requestType != XERequestTypeDownload) {
                    [self removeRequestModel:requestModel];
                }
                
            } else {
                XELog(@"=========== There is no task of this request");
            }
        }
    }];
}

- (void)handleRequesFinished:(XENetworkRequestModel *)requestModel {
    //clear all blocks
    [requestModel clearAllBlocks];
    
    //remove this requst model from request queue
    [[XENetworkRequestPool sharedPool] removeRequestModel:requestModel];
}

@end
