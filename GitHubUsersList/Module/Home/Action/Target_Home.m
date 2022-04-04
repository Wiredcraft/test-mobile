//
//  Target_Main.m
//  YUIStart
//
//  Created by 蒋来 on 2019/11/22.
//  Copyright © 2019 蒋来. All rights reserved.
//

#import "Target_Home.h"

#import "GitHubUsersList-Swift.h"

@implementation Target_Home

- (UIViewController *)Action_nativeFetchHomeViewController:(nullable NSDictionary *)params{
    
    HomeViewController *homeVC = [HomeViewController new];
    
    return homeVC;
}

- (UIViewController *)Action_nativeFetchHomeNavigationController:(nullable NSDictionary *)params{
    
    HomeViewController *homeVC = [HomeViewController new];
    
    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    return homeNC;
}

//- (void)Action_nativeRootMainTabBarController:(NSDictionary *)params{
//
//    MainTabBarController *mainTBC = [[MainTabBarController alloc] init];
//    //    [[UIApplication sharedApplication].keyWindow setRootViewController:viewController];
//
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mainTBC animated:YES completion:nil];
//}
//
//- (void)Action_nativeRootHomeNavigationController:(nullable NSDictionary *)params{
//
//    HomeViewController *homeVC = [HomeViewController new];
//
//    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
//
////    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:homeNC animated:YES completion:nil];
//}

@end
