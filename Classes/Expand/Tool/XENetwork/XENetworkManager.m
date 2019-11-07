//
//  XENetworkManager.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkManager.h"

#import "XENetworkConfig.h"
#import "XENetworkRequestPool.h"

#import "XENetworkRequestEngine.h"
#import "XENetworkUploadEngine.h"
#import "XENetworkDownloadEngine.h"


@interface XENetworkManager()

@property (nonatomic, strong) XENetworkRequestEngine *requestEngine;
@property (nonatomic, strong) XENetworkUploadEngine *uploadEngine;
@property (nonatomic, strong) XENetworkDownloadEngine *downloadEngine;

@property (nonatomic, strong) XENetworkRequestPool *requestPool;

@end

@implementation XENetworkManager

+ (XENetworkManager *_Nullable)sharedManager {
    static XENetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[XENetworkManager alloc] init];
    });
    return sharedManager;
}

- (void)dealloc {
    [self cancelAllCurrentRequests];
}

- (void)addCustomHeader:(NSDictionary *_Nonnull)header {
    [[XENetworkConfig sharedConfig] addCustomHeader:header];
}

- (NSDictionary *_Nullable)customHeaders {
    return [XENetworkConfig sharedConfig].customHeaders;
}


#pragma mark- Request API using POST method

- (void)sendGetRequest:(NSString * _Nonnull)url
               success:(XESuccessBlock _Nullable)successBlock
               failure:(XEFailureBlock _Nullable)failureBlock {
    [self.requestEngine sendRequest:url
                             method:XERequestMethodGET
                             params:nil
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(XESuccessBlock _Nullable)successBlock
               failure:(XEFailureBlock _Nullable)failureBlock {
    [self.requestEngine sendRequest:url
                             method:XERequestMethodGET
                             params:parameters
                            success:successBlock
                            failure:failureBlock];
}


#pragma mark- Request API using POST method

- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
                success:(XESuccessBlock _Nullable)successBlock
                failure:(XEFailureBlock _Nullable)failureBlock {
    [self.requestEngine sendRequest:url
                             method:XERequestMethodPOST
                             params:parameters
                            success:successBlock
                            failure:failureBlock];
}


#pragma mark- ============== Request Operation ==============

- (void)cancelAllCurrentRequests{
    [self.requestPool cancelAllCurrentRequests];
}


#pragma mark - getter/setter
- (XENetworkRequestEngine *)requestEngine{
    
    if (!_requestEngine) {
        _requestEngine = [[XENetworkRequestEngine alloc] init];
    }
    return _requestEngine;
}


- (XENetworkUploadEngine *)uploadEngine{
    
    if (!_uploadEngine) {
        _uploadEngine = [[XENetworkUploadEngine alloc] init];
    }
    return _uploadEngine;
}


- (XENetworkDownloadEngine *)downloadEngine{
    
    if (!_downloadEngine) {
        _downloadEngine = [[XENetworkDownloadEngine alloc] init];;
    }
    return _downloadEngine;
}



@end
