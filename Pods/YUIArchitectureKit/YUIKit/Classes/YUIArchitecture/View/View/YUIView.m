//
//  YUIView.m
//  YUIAll
//
//  Created by YUI on 2021/3/22.
//

#import "YUIView.h"

#import "UIView+YUISubclassingHooks.h"

#import "YUICore.h"

@implementation YUIView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self didInitialize];
        [self setupMainView];
        [self initSubviews];
        [self setupSubviewsConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self didInitialize];
        [self setupMainView];
        [self initSubviews];
        [self setupSubviewsConstraints];
    }
    return self;
}

- (void)layoutSubviews{
    
    if([self yui_hasOverrideMethod:@selector(setupSubviewsFrame) ofSuperclass:[YUIView class]]){
        
        [self setupSubviewsFrame];
    }
}

//通过响应链
- (UIViewController *)viewController{
    
    if(!_viewController){
        
        UIResponder *next = [self nextResponder];
        
        do {
            if ([next isKindOfClass:[UIViewController class]]) {
                
                _viewController = (UIViewController *)next;
                
                return _viewController;
            }
            next = [next nextResponder];
        }
        while (next != nil);
        
        return nil;
    }
    return _viewController;
}

/// 我觉得上层为subView一一绑定太过的繁琐，并且我觉得并不能很好的表达我的应用框架，所以我直接尝试在中层绑定，比起一一对应的理解上层绑定的关系，不如我直接在中层表达：如果你没有单独为view添加他的viewDelegate（它可以是viewManager或者viewModel），我将寻找下层视图的绑定情况，将代理给到他的父类的绑定
- (id<YUIViewDelegateProtocol>)viewDelegate{
    
    if (_viewDelegate == nil) {
        
        //try get from superview, lazy get
        UIView* superView = self.superview;
        while (superView != nil) {
            
            if (superView.viewDelegate != nil) {
                
                _viewDelegate = superView.viewDelegate;
                break;
            }
            superView = superView.superview;
        }
    }
    return _viewDelegate;
}

@end
