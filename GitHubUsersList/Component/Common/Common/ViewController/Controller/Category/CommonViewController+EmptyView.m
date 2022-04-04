//
//  CommonViewController+EmptyView.m
//  YUIAll
//
//  Created by YUI on 2021/3/11.
//

#import "CommonViewController+EmptyView.h"

@implementation CommonViewController (EmptyView)

//- (QMUIEmptyView *)emptyView{
//    QMUIEmptyView *tempEmptyView = objc_getAssociatedObject(self, _cmd);
//    if (!tempEmptyView && self.isViewLoaded) {
//        tempEmptyView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
//        objc_setAssociatedObject(self, @selector(emptyView), tempEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return tempEmptyView;
//}
//
//- (void)setEmptyView:(QMUIEmptyView *)emptyView{
//
//    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (BOOL)emptyViewShowing{
//
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//}
//
//- (void)setEmptyViewShowing:(BOOL)emptyViewShowing{
//
//    objc_setAssociatedObject(self, @selector(emptyViewShowing), @(emptyViewShowing), OBJC_ASSOCIATION_ASSIGN);
//}

#pragma mark - 空列表视图 QMUIEmptyView

- (QMUIEmptyView *)emptyView {
    if (!_emptyView && self.isViewLoaded) {
        _emptyView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
    }
    return _emptyView;
}

- (void)showEmptyView {
    [self.view addSubview:self.emptyView];
}

- (void)hideEmptyView {
    [_emptyView removeFromSuperview];
}

- (BOOL)isEmptyViewShowing {
    return _emptyView && _emptyView.superview;
}

- (void)showEmptyViewWithLoading {
    [self showEmptyView];
    [self.emptyView setImage:nil];
    [self.emptyView setLoadingViewHidden:NO];
    [self.emptyView setTextLabelText:nil];
    [self.emptyView setDetailTextLabelText:nil];
    [self.emptyView setActionButtonTitle:nil];
}

- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:nil text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:image text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action {
    [self showEmptyView];
    [self.emptyView setLoadingViewHidden:!showLoading];
    [self.emptyView setImage:image];
    [self.emptyView setTextLabelText:text];
    [self.emptyView setDetailTextLabelText:detailText];
    [self.emptyView setActionButtonTitle:buttonTitle];
    [self.emptyView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.emptyView.actionButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)layoutEmptyView {
    if (_emptyView) {
        // 由于为self.emptyView设置frame时会调用到self.view，为了避免导致viewDidLoad提前触发，这里需要判断一下self.view是否已经被初始化
        BOOL viewDidLoad = self.emptyView.superview && [self isViewLoaded];
        if (viewDidLoad) {
            CGSize newEmptyViewSize = self.emptyView.superview.bounds.size;
            CGSize oldEmptyViewSize = self.emptyView.frame.size;
            if (!CGSizeEqualToSize(newEmptyViewSize, oldEmptyViewSize)) {
                self.emptyView.qmui_frameApplyTransform = CGRectFlatMake(CGRectGetMinX(self.emptyView.frame), CGRectGetMinY(self.emptyView.frame), newEmptyViewSize.width, newEmptyViewSize.height);
            }
            return YES;
        }
    }
    
    return NO;
}

@end
