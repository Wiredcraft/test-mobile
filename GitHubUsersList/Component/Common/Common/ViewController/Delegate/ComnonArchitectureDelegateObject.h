//
//  ComnonArchitectureDelegateObject.h
//  YUIAll
//
//  Created by YUI on 2021/6/15.
//

#import <Foundation/Foundation.h>

#import "YUIViewDelegateProtocol.h"
#import "YUIViewModelDelegateProtocol.h"
#import "YUIViewManagerDelegateProtocol.h"
#import "YUIViewControllerDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComnonArchitectureDelegateObject : NSObject <YUIViewDelegateProtocol,YUIViewModelDelegateProtocol,YUIViewManagerDelegateProtocol,YUIViewControllerDelegateProtocol>

@property (nonatomic, weak) NSObject *delegate;

- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event;

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info;

- (void)viewManager:(id)viewManager withInfo:(NSDictionary *)info;

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
