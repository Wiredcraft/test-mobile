//
//  UIView+YUIEvent.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/3/5.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "UIView+YUIEvent.h"
#import "YUICore.h"

@implementation UIView (YUIEvent)

YUISynthesizeIdWeakProperty(viewModel, setViewModel)

YUISynthesizeIdCopyProperty(viewEventBlock, setViewEventBlock)

//YUISynthesizeBOOLProperty(yui_isControllerRootView, setYui_isControllerRootView)
//
//static char kAssociatedObjectKey_viewController;
//- (void)setViewController:(__kindof UIViewController * _Nullable)yui_viewController {
//    
//    YUIWeakObjectContainer *weakContainer = objc_getAssociatedObject(self, &kAssociatedObjectKey_viewController);
//    if (!weakContainer) {
//        weakContainer = [[YUIWeakObjectContainer alloc] init];
//    }
//    weakContainer.object = yui_viewController;
//    objc_setAssociatedObject(self, &kAssociatedObjectKey_viewController, weakContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    self.yui_isControllerRootView = !!yui_viewController;
//}
//
//- (__kindof UIViewController *)viewController {
//    if (self.yui_isControllerRootView) {
//        return (__kindof UIViewController *)((YUIWeakObjectContainer *)objc_getAssociatedObject(self, &kAssociatedObjectKey_viewController)).object;
//    }
//    return self.superview.yui_viewController;
//}

- (id<YUIViewDelegateProtocol>)viewDelegate {
    
    id currentViewDelegate = objc_getAssociatedObject(self, _cmd);
    
    if (currentViewDelegate == nil) {
        
        UIView *superView = self.superview;
        while (superView != nil) {
            if (superView.viewDelegate != nil) {
                currentViewDelegate = superView.viewDelegate;
                break;
            }
            superView = superView.superview;
        }
        
        if (currentViewDelegate != nil) {
            
            [self setViewDelegate:currentViewDelegate];
        }
    }
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewDelegate:(id<YUIViewDelegateProtocol>)viewDelegate {
    objc_setAssociatedObject(self, @selector(viewDelegate), viewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (void)viewWithViewManager:(id<YUIViewDelegateProtocol>)viewManager {
    if (viewManager) {
        self.viewDelegate = viewManager;
    }
}

//- (id<YUIViewModelDelegateProtocol>)viewModel{
//
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)setViewModel:(id<YUIViewModelDelegateProtocol>)viewModel{
//
//    objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (ViewEventBlock)viewEventBlock {
//    return objc_getAssociatedObject(self, @selector(viewEventBlock));
//}
//
//- (void)setViewEventBlock:(ViewEventBlock)viewEventBlock {
//    objc_setAssociatedObject(self, @selector(viewEventBlock), viewEventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

@end
