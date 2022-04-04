//
//  YUIViewManager.m
//  YUIAll
//
//  Created by YUI on 2021/2/21.
//

#import "YUIViewManager.h"

#import "UIView+YUIEvent.h"
#import "YUIViewModel.h"

@implementation YUIViewManager

#pragma mark - init

- (instancetype)init{
    
    self = [super init];
    
    if(self) {
        
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize{
    
    // Rewrite this func in SubClass !
}

- (__kindof UIView *)viewManagerOfManagerView{
    
    return self.managerView;
}

- (UIViewController *)viewController{
    
    if(!_viewController){
        
        if(_managerView){
            
            UIResponder *next = [_managerView nextResponder];
            
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
    }
    
    return nil;
}

#pragma mark - <YUIViewDelegate>

- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{
    
}

#pragma mark ViewModelDelegate

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{
    
}

/// 我觉得在上层一一绑定太过的繁琐，并且我觉得并不能很好的表达我的应用框架，所以我直接尝试在中层绑定，比起一一对应的理解上层绑定的关系，不如我直接在中层表达：如果你没有单独为viewManager添加他的viewManagerDelegate（它应该是一个viewModel），我将寻找下层视图的绑定情况，将代理给到他的父类的绑定
- (id<YUIViewManagerDelegateProtocol>)viewManagerDelegate{
    
    if (_viewManagerDelegate == nil) {
        
        //try get from superview, lazy get
        UIView* superView = self.managerView.superview;
        while (superView != nil) {
            
            if (!superView.viewDelegate)
                break;
            
            if ([superView.viewDelegate isKindOfClass:[YUIViewManager class]]) {
                
                YUIViewManager *superViewManager = (YUIViewManager *)superView.viewDelegate;
                
                if (superViewManager.viewManagerDelegate) {
                    
                    self.viewManagerDelegate = superViewManager.viewManagerDelegate;
                    break;
                }
            }
            else if([superView.viewDelegate isKindOfClass:[YUIViewModel class]] || ([superView.viewDelegate conformsToProtocol:@protocol(YUIViewModelProtocol)] && [superView.viewDelegate isKindOfClass:[NSObject class]])){
                
                NSObject <YUIViewModelProtocol>*superViewModel = (NSObject <YUIViewModelProtocol>*)superView.viewDelegate;
                
                if ([superViewModel conformsToProtocol:@protocol(YUIViewManagerDelegateProtocol)]) {
                    
                    self.viewManagerDelegate = (NSObject <YUIViewModelProtocol,YUIViewManagerDelegateProtocol>*) superViewModel;
                    break;
                }
            }
            
            superView = superView.superview;
        }
    }
    
    return _viewManagerDelegate;
}

@end
