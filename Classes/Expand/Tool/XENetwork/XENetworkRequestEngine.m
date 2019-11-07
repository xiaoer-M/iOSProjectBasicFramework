//
//  XENetworkRequestEngine.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkRequestEngine.h"
#import "XENetworkConfig.h"
#import "XENetworkUtils.h"
#import "XENetworkRequestModel.h"
#import "XENetworkRequestPool.h"

@interface XENetworkRequestEngine ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, assign) BOOL isDebugLog;

@end

@implementation XENetworkRequestEngine

- (instancetype)init {
    self = [super init];
    if (self) {
        _isDebugLog = [XENetworkConfig sharedConfig].debugLog;
        
        //AFN设置
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
        //requestSerializer
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = [XENetworkConfig sharedConfig].timeoutInterval;
        _sessionManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
        //responseSerializer
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", @"image/jpeg", @"application/zip", nil];
        
    }
    return self;
}

- (void)sendRequest:(NSString *)url
             method:(XERequestMethod)method
             params:(id)params
            success:(XESuccessBlock)successBlock
            failure:(XEFailureBlock)failureBlock {
    // 拼接URL
    NSString *completeUrlStr = [XENetworkUtils generateCompleteRequestUrlStrWithBaseUrlStr:[XENetworkConfig sharedConfig].baseUrl requestUrlStr:url];
    
    // 请求方式
    NSString *methodStr = [self p_methodStringFromRequestMethod:method];
    
    // 请求标识
    NSString *requestIdentifer = [XENetworkUtils generateRequestIdentiferWithBaseUrlStr:[XENetworkConfig sharedConfig].baseUrl
                                                                          requestUrlStr:url
                                                                              methodStr:methodStr
                                                                             parameters:params];
    
    [self p_sendRequestWithCompleteUrlStr:completeUrlStr method:methodStr params:params requestIdentifer:requestIdentifer success:successBlock failure:failureBlock];
}

#pragma mark - ============= Private method ============
- (void)p_sendRequestWithCompleteUrlStr:(NSString *)completeUrlStr
                                 method:(NSString *)methodStr
                                 params:(id)params
                       requestIdentifer:(NSString *)requestIdentifer
                                success:(XESuccessBlock)successBlock
                                failure:(XEFailureBlock)failureBlock {
    // 设置自定义请求头
    [self p_addCustomHeader];
    
    // 添加默认参数
    NSDictionary *completeParameters = [self p_addDefaultParametersWithCustomParameters:params];
    
    // 创建请求模型
    XENetworkRequestModel *requestModel = [[XENetworkRequestModel alloc] init];
    requestModel.requestUrl = completeUrlStr;
    requestModel.method = methodStr;
    requestModel.params = completeParameters;
    requestModel.requestIdentifer = requestIdentifer;
    requestModel.successBlock = successBlock;
    requestModel.failureBlock = failureBlock;
    
    NSError * __autoreleasing requestSerializationError = nil;
    NSURLSessionDataTask *dataTask = [self p_dataTaskWithRequestModel:requestModel error:&requestSerializationError];
    
    requestModel.task = dataTask;
    
    if (_isDebugLog) {
        XELog(@"=========== Start requesting...\n =========== url:%@\n =========== method:%@\n =========== parameters:%@",completeUrlStr,methodStr,completeParameters);
    }
    
    [dataTask resume];
}

- (NSURLSessionDataTask *)p_dataTaskWithRequestModel:(XENetworkRequestModel *)requestModel
                                               error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableURLRequest *request = [_sessionManager.requestSerializer requestWithMethod:requestModel.method
                                                                              URLString:requestModel.requestUrl
                                                                             parameters:requestModel.params
                                                                                  error:error];
    
    
    
    //create data task
    __weak __typeof(self) weakSelf = self;
    NSURLSessionDataTask * dataTask = [_sessionManager dataTaskWithRequest:request
                                                            uploadProgress:nil
                                                          downloadProgress:nil
                                                         completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
                                                             
                                                             [weakSelf p_handleRequestModel:requestModel responseObject:responseObject error:error];
                                                         }];
    
    return dataTask;
}

- (void)p_handleRequestModel:(XENetworkRequestModel *)requestModel
              responseObject:(id)responseObject
                       error:(NSError *)error{
    
    NSError *requestError = nil;
    BOOL requestSucceed = YES;
    
    //check request state
    if (error) {
        requestSucceed = NO;
        requestError = error;
    }
    
    if (requestSucceed) {
        //request succeed
        requestModel.responseObject = responseObject;
        [self p_requestDidSucceedWithRequestModel:requestModel];
    } else {
        //request failed
        [self p_requestDidFailedWithRequestModel:requestModel error:requestError];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleRequesFinished:requestModel];
    });
}

- (void)p_requestDidSucceedWithRequestModel:(XENetworkRequestModel *)requestModel{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.isDebugLog) {
            // 转字符串打印方便
            #ifdef DEBUG
            NSString *responseString = [[NSString alloc] initWithData:requestModel.responseObject encoding:NSUTF8StringEncoding];
            #endif
            
            XELog(@"=========== Request succeed! \n =========== Request url:%@\n =========== Response object:%@", requestModel.requestUrl,responseString);
        }
        
        NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:requestModel.responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (requestModel.successBlock) {
            requestModel.successBlock(responseJson);
        }
    });
    
}


- (void)p_requestDidFailedWithRequestModel:(XENetworkRequestModel *)requestModel error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isDebugLog) {
            XELog(@"=========== Request failded! \n =========== Request model:%@ \n =========== NSError object:%@ \n =========== Status code:%ld",requestModel,error,(long)error.code);
        }
        
        if (requestModel.failureBlock){
            requestModel.failureBlock(requestModel.task, error, error.code);
        }
    });
}


- (NSString *)p_methodStringFromRequestMethod:(XERequestMethod)method {
    switch (method) {
        case XERequestMethodGET:{
            return @"GET";
        }
            break;
            
        case XERequestMethodPOST:{
            return  @"POST";
        }
            break;
            
        case XERequestMethodPUT:{
            return  @"PUT";
        }
            break;
            
        case XERequestMethodDELETE:{
            return  @"DELETE";
        }
            
        break;
    }
}

- (void)p_addCustomHeader {
    NSDictionary *customHeaders = [XENetworkConfig sharedConfig].customHeaders;
    if ([customHeaders allKeys] > 0) {
        [customHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.responseSerializer setValue:obj forKey:key];
            if (self.isDebugLog) {
                XELog(@"=========== added header:key:%@ value:%@",key,obj);
            }
        }];
    }
}

- (id)p_addDefaultParametersWithCustomParameters:(id)parameters {
    id parameters_spliced = nil;
    
    if (parameters && [parameters isKindOfClass:[NSDictionary class]]) {
        if ([[[XENetworkConfig sharedConfig].defaultParams allKeys] count] > 0) {
            NSMutableDictionary *defaultParameters_m = [[XENetworkConfig sharedConfig].defaultParams mutableCopy];
            [defaultParameters_m addEntriesFromDictionary:parameters];
            parameters_spliced = [defaultParameters_m copy];
        }else{
            parameters_spliced = parameters;
        }
    }else{
        parameters_spliced = [XENetworkConfig sharedConfig].defaultParams;
    }
    
    return parameters_spliced;
}

- (void)handleRequesFinished:(XENetworkRequestModel *)requestModel{
    //clear all blocks
    [requestModel clearAllBlocks];
    
    //remove this requst model from request queue
    [[XENetworkRequestPool sharedPool] removeRequestModel:requestModel];
    
}

@end
