//
//  CommonViewController+MVVM.m
//  YUIAll
//
//  Created by YUI on 2021/5/26.
//

#import "CommonViewController+SubclassingHooks.h"

@implementation CommonViewController (SubclassingHooks)

#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{

    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(viewController:withInfo:)]){

        [self.architectureDelegateObject viewController:viewController withInfo:info];
    }
}

#pragma mark - <YUIViewDelegateProtocol>

//既然使用dict作为信息转递决定具体的操作，我在中层添加了一种集约型模式转换为离散型模式的一种可能，并且以此弱化硬编码，优化上层判断
- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{

    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(view:withEvent:)]){

        [self.architectureDelegateObject view:view withEvent:event];
    }
}

#pragma mark - <YUIViewModelDelegateProtocol>

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{

    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(viewModel:withInfo:)]){

        [self.architectureDelegateObject viewModel:viewModel withInfo:info];
    }
}

- (ComnonArchitectureDelegateObject *)architectureDelegateObject{

    if(!_architectureDelegateObject){

        _architectureDelegateObject = [ComnonArchitectureDelegateObject new];
        _architectureDelegateObject.delegate = self;
    }
    return _architectureDelegateObject;
}

@end
