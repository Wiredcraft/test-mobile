//
//  CommonViewController+EmptyView.h
//  YUIAll
//
//  Created by YUI on 2021/3/11.
//

#import "CommonViewController.h"

#import <QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonViewController (){
    QMUIEmptyView *_emptyView;
    BOOL _emptyViewShowing;
}
/**
 *  空列表控件，支持显示提示文字、loading、操作按钮，该属性懒加载
 */
@property(nullable, nonatomic, strong) QMUIEmptyView *emptyView;

/// 当前self.emptyView是否显示
@property(nonatomic, assign, readonly, getter = isEmptyViewShowing) BOOL emptyViewShowing;

@end

@interface CommonViewController (EmptyView)

/**
 *  显示emptyView
 *  emptyView 的以下系列接口可以按需进行重写
 *
 *  @see QMUIEmptyView
 */
- (void)showEmptyView;

/**
 *  显示loading的emptyView
 */
- (void)showEmptyViewWithLoading;

/**
 *  显示带text、detailText、button的emptyView
 */
- (void)showEmptyViewWithText:(nullable NSString *)text
                   detailText:(nullable NSString *)detailText
                  buttonTitle:(nullable NSString *)buttonTitle
                 buttonAction:(nullable SEL)action;

/**
 *  显示带image、text、detailText、button的emptyView
 */
- (void)showEmptyViewWithImage:(nullable UIImage *)image
                          text:(nullable NSString *)text
                    detailText:(nullable NSString *)detailText
                   buttonTitle:(nullable NSString *)buttonTitle
                  buttonAction:(nullable SEL)action;

/**
 *  显示带loading、image、text、detailText、button的emptyView
 */
- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(nullable UIImage *)image
                            text:(nullable NSString *)text
                      detailText:(nullable NSString *)detailText
                     buttonTitle:(nullable NSString *)buttonTitle
                    buttonAction:(nullable SEL)action;

/**
 *  隐藏emptyView
 */
- (void)hideEmptyView;

/**
 *  布局emptyView，如果emptyView没有被初始化或者没被添加到界面上，则直接忽略掉。
 *
 *  如果有特殊的情况，子类可以重写，实现自己的样式
 *
 *  @return YES表示成功进行一次布局，NO表示本次调用并没有进行布局操作（例如emptyView还没被初始化）
 */
- (BOOL)layoutEmptyView;

@end

NS_ASSUME_NONNULL_END
