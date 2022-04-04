//
//  UIView+YUISubclassingHooks.m
//  YUIAll
//
//  Created by YUI on 2021/3/19.
//

#import "UIView+YUISubclassingHooks.h"

@implementation UIView (YUISubclassingHooks)

- (void)didInitialize{
    // Rewrite this func in SubClass !
}

- (void)setupMainView{
    // Rewrite this func in SubClass !
}

- (void)initSubviews{
    // Rewrite this func in SubClass !
}

- (void)setupSubviewsFrame{
    // Rewrite this func in SubClass !
}

- (void)setupSubviewsConstraints{
    // Rewrite this func in SubClass !
}

- (void)configureGesture{
    // Rewrite this func in SubClass !
}

- (void)updateSubviews:(nullable id)model{
    // Rewrite this func in SubClass !
}

- (void)updateSubviewsLayout:(nullable id)model{
    // Rewrite this func in SubClass !
}

- (void)configureViewWithModel:(id)model{
    // Rewrite this func in SubClass !
}
    
- (void)configureViewWithViewModel:(id<YUIViewModelDelegateProtocol>)viewModel{
    // Rewrite this func in SubClass !
}

+ (CGSize)calculateSize:(nullable id)model{
    
    // Rewrite this func in SubClass !
    return CGSizeZero;
}

- (CGSize)calculateSize:(nullable id)model{
    
    // Rewrite this func in SubClass !
    return CGSizeZero;
}

@end
