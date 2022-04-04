//
//  YUIViewControllerDelegateProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/4/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIViewControllerDelegateProtocol <NSObject>

@optional

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
