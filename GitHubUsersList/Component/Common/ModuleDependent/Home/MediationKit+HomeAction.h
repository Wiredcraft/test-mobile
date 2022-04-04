//
//  MediationKit+ExampleObj.h
//  YUIAll
//
//  Created by YUI on 2021/8/27.
//

#import "MediationKit.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MediationKit (HomeAction)

- (UIViewController *)viewControllerForHome;

- (UINavigationController *)navigationControllerForHome;

@end

NS_ASSUME_NONNULL_END
