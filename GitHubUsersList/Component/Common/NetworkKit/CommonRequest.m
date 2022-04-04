//
//  CommonRequest.m
//  YUIAll
//
//  Created by YUI on 2020/9/17.
//  Copyright © 2020 YUI. All rights reserved.
//

#import "CommonRequest.h"

@implementation CommonRequest

@dynamic successCompletionBlock;
@dynamic failureCompletionBlock;

-(instancetype)init{
    
    if (self = [super init]) {
        
        self.rootURLStr = @"";
        self.prefixRequestURLStr = @"";
        self.requestURLStr = @"";
    }
    
    return self;
}

- (NSString *)requestUrl {

    NSString *uRLStr = [NSString stringWithFormat:@"%@%@%@",self.rootURLStr,self.prefixRequestURLStr,self.requestURLStr];

    return uRLStr;
}

//-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
//    
//    NSMutableDictionary *requestHearders = [NSMutableDictionary new];
////    requestHearders setValue: forKey:<#(nonnull NSString *)#>
//    return requestHearders;
//}

- (void)setCompletionBlockWithSuccess:(nullable RequestCompletionBlock)success
                              failure:(nullable RequestCompletionBlock)failure{
    
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

@end
