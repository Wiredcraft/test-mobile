//
//  NetworkKit.m
//  YUIAll
//
//  Created by YUI on 2020/9/16.
//  Copyright © 2020 YUI. All rights reserved.
//

#import "NetworkKit.h"

@interface NetworkKit ()<YTKRequestDelegate>

typedef void(^NetworkKitRequestCompletionBlock)(__kindof YTKBaseRequest *request);

@end

@implementation NetworkKit

+ (instancetype)sharedInstance{
    
    //Singleton instance
    static NetworkKit *networkKit;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        networkKit = [[self alloc] init];
    });
    
    return networkKit;
}

- (void)requestWithRequest:(id)request{
    
    if ([request isKindOfClass:[CommonRequest class]]) {
        
        CommonRequest *commonRequest = (CommonRequest *)request;
        commonRequest.delegate = self;
        [commonRequest start];
    }
    else{
        
    }
}

- (void)requestWithRequest:(id)request
                   success:(RequestSuccessBlock _Nullable)success
                   failure:(RequestFailureBlock _Nullable)failure{
    
    if ([request isKindOfClass:[CommonRequest class]]) {
        
        [request startWithCompletionBlockWithSuccess:^(__kindof CommonRequest * _Nonnull request) {
            
            [self requestFinishedHandlerResult:request success:success];
            
        } failure:^(__kindof CommonRequest * _Nonnull request) {
            
            [self requestFailedHandlerResult:request failure:failure];
        }];
    }
    else{
        
    }
}

- (void)requestWithRequest2:(id)request{
    
}

- (void)requestURLString:(NSString *)uRLString parameter:(NSDictionary *)parameter method:(NSString *)method name:(NSString *)name userInfo:(id<NSObject>)userInfo{
    
}

- (void)requestFinishedHandlerResult:(id)result success:(RequestSuccessBlock _Nullable)success{
    
    RequestSuccessBlock successCompletionBlock;
    
    if ([result isKindOfClass:[CommonRequest class]]) {
        
        CommonRequest *request = (CommonRequest *)result;
        
        //        if([[request.responseJSONObject allKeys]containsObject:@"code"]){
        //
        //            request.businessStatusCode = [request.responseJSONObject objectForKey:@"code"];
        //        }
        //
        //        if([[request.responseJSONObject allKeys]containsObject:@"data"]){
        //
        //            request.responseDateContent = [request.responseJSONObject objectForKey:@"data"];
        //        }
        
        if (success) {
            
            successCompletionBlock = ^(CommonRequest *result, id reponseObject){
                
                success(result, reponseObject);
            };
            successCompletionBlock(result, request.responseObject);
            
            return;
        }
        
        if(_delegate && [_delegate respondsToSelector:@selector(requestSuccessHandlerResult:)]){
            
            [_delegate requestSuccessHandlerResult:result];
            
            return;
        }
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(requestFinishedHandlerResult:)]){
        
        [_delegate requestFinishedHandlerResult:result];
        
        return;
    }
}

- (void)requestFailedHandlerResult:(id)result failure:(RequestFailureBlock _Nullable)failure{
    
    NSError *error;
    RequestFailureBlock failureCompletionBlock;
    
    if ([result isKindOfClass:[CommonRequest class]]) {
        
        CommonRequest *request = (CommonRequest *)result;
        
        error = request.error;
    }
    
    if (failure) {
        
        failureCompletionBlock = ^(NSError *error){
            
            failure(error);
        };
        
        failureCompletionBlock(error);
        
        return;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(requestFailedHandlerResult:)]){
        
        [_delegate requestFailedHandlerResult:result];
        
        return;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(requestFinishedHandlerResult:)]){
        
        [_delegate requestFinishedHandlerResult:result];
        
        return;
    }
}

#pragma mark - <YTKRequestDelegate>

- (void)requestFinished:(__kindof CommonRequest *)request{
    
    //    [self requestFinishedHandlerResult:request success:^(NSDictionary * _Nonnull resultDict){
    //
    //        request.successCompletionBlock(request);
    //    }];
}

- (void)requestFailed:(__kindof CommonRequest *)request{
    
    [self requestFailedHandlerResult:request failure:^(NSError * _Nonnull error) {
        
        request.failureCompletionBlock(request);
    }];
}

@end
