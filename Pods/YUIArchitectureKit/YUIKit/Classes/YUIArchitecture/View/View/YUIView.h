//
//  YUIView.h
//  YUIAll
//
//  Created by YUI on 2021/3/22.
//

#import <UIKit/UIKit.h>

#import "UIView+YUIEvent.h"
#import "YUIViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIView : UIView <YUIViewProtocol>

/**
 获取当前 view 所在的 UIViewController，会递归查找 superview，因此注意使用场景不要有过于频繁的调用
 */
@property(nullable, nonatomic, weak) __kindof UIViewController *viewController;

@property (nullable, nonatomic, weak) id<YUIViewDelegateProtocol> viewDelegate;

@end

NS_ASSUME_NONNULL_END
