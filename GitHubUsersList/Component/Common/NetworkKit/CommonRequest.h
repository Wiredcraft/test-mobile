//
//  CommonRequest.h
//  YUIAll
//
//  Created by YUI on 2020/9/17.
//  Copyright © 2020 YUI. All rights reserved.
//

#import "YTKNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@class CommonRequest;

typedef void(^RequestCompletionBlock)(__kindof CommonRequest *request);


@interface CommonRequest : YTKRequest

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *rootURLStr;

@property (nonatomic, copy) NSString *prefixRequestURLStr;

@property (nonatomic, copy) NSString *requestURLStr;


@property (nonatomic, copy) NSString *businessStatusCode;

@property (nonatomic, copy) NSString *businessMessage;


@property (nonatomic, strong) id responseDateContent;

@property (nonatomic, strong) id responseDateObject;


@property (nonatomic, copy, nullable) RequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy, nullable) RequestCompletionBlock failureCompletionBlock;


- (void)setCompletionBlockWithSuccess:(nullable RequestCompletionBlock)success
                              failure:(nullable RequestCompletionBlock)failure;

@end

NS_ASSUME_NONNULL_END
