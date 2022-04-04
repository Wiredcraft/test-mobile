//
//  MediationKit+HandyTools.h
//  YUIAll
//
//  Created by YUI on 2021/8/27.
//

#import "MediationKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediationKit (HandyTools)

- (UIViewController * _Nullable)topViewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable )(void))completion;

@end

NS_ASSUME_NONNULL_END
