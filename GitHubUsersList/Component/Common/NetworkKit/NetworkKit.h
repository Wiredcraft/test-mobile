//
//  NetworkKit.h
//  YUIAll
//
//  Created by YUI on 2020/9/16.
//  Copyright © 2020 YUI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YTKNetwork.h"
#import "CommonRequest.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkKitDelegate <NSObject>

@optional

//请求完整结果回调
//- (void)requestResultDictionary:(NSDictionary *)resultDictionary name:(NSString *)name tag:(NSInteger)tag userInfo:(id<NSObject>)userInfo error:(NSError *)error;

- (void)requestSuccessHandlerResult:(id)result;

- (void)requestFailedHandlerResult:(id)result;

- (void)requestFinishedHandlerResult:(id)result;

@end


// 访问成功block
typedef void (^RequestSuccessBlock)(CommonRequest * _Nullable resultRequest, id _Nullable reponseObject);

// 访问失败block
typedef void (^RequestFailureBlock)(NSError * _Nullable error);


@interface NetworkKit : NSObject

@property (nonatomic, weak) id<NetworkKitDelegate> delegate;

+ (instancetype)sharedInstance;

/// API请求接口
/// 项目通用层特性现支持YTKRequest
/// @param request YTKRequest及其子类及其他未实现
- (void)requestWithRequest:(id)request;

- (void)requestWithRequest:(id)request
                  success:(RequestSuccessBlock _Nullable)success
                  failure:(RequestFailureBlock _Nullable)failure;

/// API请求接口
/// 未实现
- (void)requestURLString:(NSString *)uRLString parameter:(NSDictionary *)parameter method:(NSString *)method name:(NSString *)name userInfo:(id<NSObject>)userInfo;

@end

NS_ASSUME_NONNULL_END
