//
//  UIView+YUISubclassingHooks.h
//  YUIAll
//
//  Created by YUI on 2021/3/19.
//

#import <UIKit/UIKit.h>

#import "YUIViewModelDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YUISubclassingHooks)

- (void)didInitialize;

- (void)setupMainView;

- (void)initSubviews;

///  负责subviews使用setFrame布局
- (void)setupSubviewsFrame;

///  负责subviews使用layout布局
- (void)setupSubviewsConstraints;

///  负责配置手势
- (void)configureGesture;

///  负责更新视图
- (void)updateSubviews:(nullable id)model;

///  负责更新视图布局
- (void)updateSubviewsLayout:(nullable id)model;

///  负责传入模型直接赋值
- (void)configureViewWithModel:(id)model;

///  负责传入ViewModel直接赋值
- (void)configureViewWithViewModel:(id<YUIViewModelDelegateProtocol>)viewModel;

///  负责传入模型计算视图动态的尺寸
+ (CGSize)calculateSize:(nullable id)model;

///  负责传入模型计算视图动态的尺寸
- (CGSize)calculateSize:(nullable id)model;

@end

NS_ASSUME_NONNULL_END
