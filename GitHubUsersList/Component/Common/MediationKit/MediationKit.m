//
//  MediationKit.m
//  YUIAll
//
//  Created by YUI on 2021/8/27.
//

#import "MediationKit.h"

#import <CTMediator.h>

@interface MediationKit ()

@property (nonatomic, strong) CTMediator *mediator;

@end


@implementation MediationKit

+ (instancetype)sharedInstance{
    
    //Singleton instance
    static MediationKit *mediationKit;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        mediationKit = [[self alloc] init];
    });
    
    mediationKit.mediator = [CTMediator sharedInstance];
    
    return mediationKit;
}

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion{
    
    return [self.mediator performActionWithUrl:url completion:completion];
}

// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(nullable NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    return [self.mediator performTarget:targetName action:actionName params:params shouldCacheTarget:shouldCacheTarget];
}

- (void)releaseCachedTargetWithFullTargetName:(NSString *)targetName{
    
    [self.mediator releaseCachedTargetWithFullTargetName:targetName];
}

@end
