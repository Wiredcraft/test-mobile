//
//  Target_Main.h
//  YUIStart
//
//  Created by 蒋来 on 2019/11/22.
//  Copyright © 2019 蒋来. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_Home : NSObject

- (UIViewController *)Action_nativeFetchHomeViewController:(nullable NSDictionary *)params;

- (UIViewController *)Action_nativeFetchHomeNavigationController:(nullable NSDictionary *)params;

//- (void)Action_nativeRootMainTabBarController:(nullable NSDictionary *)params;
//
//- (void)Action_nativeRootHomeNavigationController:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
