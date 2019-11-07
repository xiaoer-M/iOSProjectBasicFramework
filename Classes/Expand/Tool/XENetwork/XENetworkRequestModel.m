//
//  XENetworkRequestModel.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XENetworkRequestModel.h"
#import "XENetworkConfig.h"
#import "XENetworkUtils.h"

@interface XENetworkRequestModel()

@property (nonatomic, readwrite, copy) NSString *cacheDataFilePath;
@property (nonatomic, readwrite, copy) NSString *cacheDataInfoFilePath;

@property (nonatomic, readwrite, copy) NSString *resumeDataFilePath;
@property (nonatomic, readwrite, copy) NSString *resumeDataInfoFilePath;

@end

@implementation XENetworkRequestModel

- (XERequestType)requestType {
    if (self.downloadFilePath){
        
        return XERequestTypeDownload;
        
    } else if (self.uploadUrl) {
        
        return XERequestTypeUpload;
        
    } else {
        
        return XERequestTypeOrdinary;
        
    }
}

- (NSString *)cacheDataFilePath {
    if (self.requestType == XERequestTypeOrdinary) {
        
        if (_cacheDataFilePath.length > 0) {
            
            return _cacheDataFilePath;
            
        }else{
            
            _cacheDataFilePath = [XENetworkUtils cacheDataFilePathWithRequestIdentifer:_requestIdentifer];
            return _cacheDataFilePath;
        }
        
    } else {
        return @"";
    }
}

- (NSString *)cacheDataInfoFilePath {
    if (self.requestType == XERequestTypeOrdinary) {
        
        if (_cacheDataInfoFilePath.length > 0) {
            
            return _cacheDataInfoFilePath;
            
        }else{
            
            _cacheDataInfoFilePath = [XENetworkUtils cacheDataInfoFilePathWithRequestIdentifer:_requestIdentifer];
            return _cacheDataInfoFilePath;
        }
        
    }else{
        
        return @"";
    }
}

- (NSString *)resumeDataFilePath {
    if (self.requestType == XERequestTypeDownload) {
        
        if (_resumeDataFilePath.length > 0) {
            
            return _resumeDataFilePath;
            
        }else{
            
            _resumeDataFilePath = [XENetworkUtils resumeDataFilePathWithRequestIdentifer:_requestIdentifer downloadFileName:_downloadFilePath.lastPathComponent];
            return _resumeDataFilePath;
        }
        
    }else{
        
        return @"";
        
    }
}

- (NSString *)resumeDataInfoFilePath {
    if (self.requestType == XERequestTypeDownload) {
        
        if (_resumeDataInfoFilePath.length > 0) {
            
            return _resumeDataInfoFilePath;
            
        }else{
            
            _resumeDataInfoFilePath = [XENetworkUtils resumeDataInfoFilePathWithRequestIdentifer:_requestIdentifer];
            return _resumeDataInfoFilePath;
        }
        
    }else{
        
        return @"";
        
    }
}

- (void)clearAllBlocks {
    _successBlock = nil;
    _failureBlock = nil;
    
    _uploadProgressBlock = nil;
    _uploadSuccessBlock = nil;
    _uploadFailedBlock = nil;
    
    _downloadProgressBlock = nil;
    _downloadSuccessBlock = nil;
    _downloadFailureBlock= nil;
}

#pragma mark- ============== Override Methods ==============

- (NSString *)description{
    
    if ([XENetworkConfig sharedConfig].debugLog) {
        
        switch (self.requestType) {
                
            case XERequestTypeOrdinary:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            oridnary request\n   method:          %@\n   url:             %@\n   parameters:      %@\n    requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_params,_requestIdentifer,_task];
                break;
                
            case XERequestTypeUpload:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            upload request\n   method:          %@\n   url:             %@\n   parameters:      %@\n   images:          %@\n    requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_params,_uploadImages,_requestIdentifer,_task];
                break;
                
            case XERequestTypeDownload:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            download request\n   method:          %@\n   url:             %@\n   parameters:      %@\n   target path:     %@\n    requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_params,_downloadFilePath,_requestIdentifer,_task];
                break;
                
            default:
                [NSString stringWithFormat:@"\n  request type:unkown request type\n  request object:%@",self];
                break;
        }
        
        
    }else{
        
        return [NSString stringWithFormat:@"<%@: %p>" ,NSStringFromClass([self class]),self];
    }
}


@end
