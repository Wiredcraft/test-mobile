//
//  YUIViewController+MVVM.m
//  YUIAll
//
//  Created by YUI on 2020/12/14.
//

#import "YUIViewController+MVVM.h"

#import "YUIViewController+YUISubclassingHooks.h"

#import "YUIModelManagerProtocol.h"
#import "YUIViewDelegateProtocol.h"
#import "UIView+YUIEvent.h"
#import "YUIViewManager.h"
#import "YUIViewModel.h"

@implementation YUIViewController (MVVM)

#pragma mark - init

- (void)mvvm_configureArchitectureWithBindingName:(NSString *)bindingName{
    
    //  mainView
    Class mainViewClass = NSClassFromString([NSString stringWithFormat:@"%@View", bindingName]);
    if (mainViewClass != NULL && [mainViewClass conformsToProtocol:@protocol(YUIViewProtocol)]) {
        
        self.mainView = [mainViewClass new];
    }
    
    //  ViewModel
    Class viewModelClass = NSClassFromString([NSString stringWithFormat:@"%@ViewModel", bindingName]);
    if (viewModelClass != NULL && [viewModelClass conformsToProtocol:@protocol(YUIViewModelProtocol)]) {
        
        self.viewModel = [viewModelClass new];
    }
    
    //  ViewManager
    Class viewManagerClass = NSClassFromString([NSString stringWithFormat:@"%@ViewManager", bindingName]);
    if (viewManagerClass != NULL && [viewManagerClass conformsToProtocol:@protocol(YUIViewManagerProtocol)]) {
        
        self.viewManager = [viewManagerClass new];
    }
}

//- (void)mvvm_didInitialize{
//
//}

#pragma mark - Lifecycle

- (void)mvvm_viewDidLoad{
    
    [self setupMainView];
    
    [self initSubviews];
    
    [self configureBingding];
    
    [self setupSubviewsConstraints];
}

//不可直接在分类中使用定义的同名子类继承的方法
- (void)mvvm_configureBingding{
    
    if(self.mainView && self.viewModel && self.viewManager){
        
        //  绑定viewManager与view
        if([self.viewManager conformsToProtocol:@protocol(YUIViewDelegateProtocol)]){
            
            [self.mainView viewWithViewManager:(NSObject<YUIViewDelegateProtocol>*)self.viewManager];
        }
        if([self.viewManager isKindOfClass:[YUIViewManager class]]){
            
            YUIViewManager *yuiViewManager = (YUIViewManager *)self.viewManager;
            yuiViewManager.managerView = self.mainView;
            yuiViewManager.viewController = self;
        }
        
        //  绑定viewManager与viewModel
        if([self.viewModel isKindOfClass:[YUIViewModel class]] && [self.viewManager conformsToProtocol:@protocol(YUIViewModelDelegateProtocol)]){
            
            [(YUIViewModel *)self.viewModel setViewModelDelegate:(id<YUIViewModelDelegateProtocol>)self.viewManager];
        }
        if([self.viewManager isKindOfClass:[YUIViewManager class]] && [self.viewModel conformsToProtocol:@protocol(YUIViewManagerDelegateProtocol)]){
            
            [(YUIViewManager *)self.viewManager setViewManagerDelegate:(id<YUIViewManagerDelegateProtocol>)self.viewModel];
        }
    }
    //不使用viewManager，通常绑定，将mainView绑定controller，viewModel绑定controller，理解上可以将mainView直接绑定viewModel，但是缺失了一个通过controller互相切换绑定的结点
    else if(self.mainView && self.viewModel && !self.viewManager){
        
        if([self conformsToProtocol:@protocol(YUIViewDelegateProtocol)]){
            
            self.mainView.viewDelegate = self;
        }
        if([self.viewModel isKindOfClass:[YUIViewModel class]]){
            
            [(YUIViewModel *)self.viewModel setViewModelDelegate:self];
        }
    }
}


- (void)mvvm_viewDidLayoutSubviews{
    
    [self setupSubviewsFrame];
}

- (void)mvvm_dealloc{
    
    [self cleanupObserver];
}

//- (NSObject <YUIViewModelProtocol>*)viewModel {
//    
//    if (!_viewModel) {
//        
//        Class viewModelClass = NSClassFromString([NSString stringWithFormat:@"%@ViewModel",self.bindingName]);
//        if (viewModelClass != NULL && [viewModelClass conformsToProtocol:@protocol(YUIViewModelProtocol)]) {
//            
//            _viewModel = [viewModelClass new];
//        }
//    }
//    return _viewModel;
//}

//#pragma mark - UITableViewDelegate
#pragma mark - ViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods
#pragma mark - getters and setters

@end
