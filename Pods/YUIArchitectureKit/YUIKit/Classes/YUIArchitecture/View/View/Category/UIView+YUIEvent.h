//
//  UIView+YUIEvent.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUIViewDelegateProtocol.h"
#import "YUIViewManagerDelegateProtocol.h"
#import "YUIViewModelDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ViewEventBlock)( void);

@interface UIView (YUIEvent)

/**
 获取当前 view 所在的 UIViewController，会递归查找 superview，因此注意使用场景不要有过于频繁的调用
 */
//@property(nullable, nonatomic, weak) __kindof UIViewController *viewController;

/**
 *  viewDelegate 传递事件
 */
@property (nullable, nonatomic, weak) id<YUIViewDelegateProtocol> viewDelegate;

///view 引用viewModel ，但反过来不行（即不要在viewModel中引入#import UIKit.h，任何视图本身的引用都不应该放在viewModel中）
@property (nullable, nonatomic, weak) id<YUIViewModelDelegateProtocol> viewModel;

/**
 *  block 传递事件
 */
@property (nonatomic, copy) ViewEventBlock viewEventBlock;

/**
 *  将view中的事件交由viewManager处理
 */
- (void)viewWithViewManager:(id<YUIViewDelegateProtocol>)viewManager;

@end

NS_ASSUME_NONNULL_END

