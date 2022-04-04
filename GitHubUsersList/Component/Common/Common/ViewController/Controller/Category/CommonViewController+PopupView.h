//
//  CommonViewController+PopupView.h
//  YUIAll
//
//  Created by YUI on 2021/11/1.
//

#import "CommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonViewController (){
    UIView *_popupView;
    BOOL _popupViewShowing;
}
/**
 *  弹窗控件，支持显示提示文字、loading、操作按钮，该属性懒加载
 */
@property(nullable, nonatomic, strong) UIView *popupView;

/// 当前self.popupView是否显示
@property(nonatomic, assign, readonly, getter = isPopupViewShowing) BOOL popupViewShowing;

@end

@interface CommonViewController (PopupView)

/**
 *  显示popupView
 *  popupView 的以下系列接口可以按需进行重写
 *
 *  @see QMUIEmptyView
 */
- (void)showPopupView;

/**
 *  隐藏popupView
 */
- (void)hidePopupView;

/**
 *  显示loading的popupView
 */
- (void)showPopupViewWithLoading;

/**
 *  隐藏loading的popupView
 */
- (void)hidePopupViewWithLoading;

@end

NS_ASSUME_NONNULL_END
