//
//  MediationKit.h
//  YUIAll
//
//  Created by YUI on 2021/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MediationKitDelegate <NSObject>

@end

@interface MediationKit : NSObject

@property (nonatomic, weak, nullable) id<MediationKitDelegate> delegate;

+ (instancetype _Nonnull)sharedInstance;

// 远程App调用入口
- (id _Nullable)performActionWithUrl:(NSURL * _Nullable)url completion:(void(^_Nullable)(NSDictionary * _Nullable info))completion;
// 本地组件调用入口
- (id _Nullable )performTarget:(NSString * _Nullable)targetName action:(NSString * _Nullable)actionName params:(NSDictionary * _Nullable)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithFullTargetName:(NSString * _Nullable)fullTargetName;

@end

NS_ASSUME_NONNULL_END
