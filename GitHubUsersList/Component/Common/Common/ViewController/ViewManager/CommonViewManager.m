//
//  CommonViewManager.m
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import "CommonViewManager.h"

#import "ComnonArchitectureDelegateObject.h"

@interface CommonViewManager ()

@property (nonatomic, strong) ComnonArchitectureDelegateObject *architectureDelegate;

@end

@implementation CommonViewManager

#pragma mark - <YUIViewDelegate>

//既然使用dict作为信息转递决定具体的操作，我在中层添加了一种集约型模式转换为离散型模式的一种可能，并且以此弱化硬编码，优化上层判断
- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{
    
    if(self.architectureDelegate && [self.architectureDelegate respondsToSelector:@selector(view:withEvent:)]){
        
        [self.architectureDelegate view:view withEvent:event];
    }
}

#pragma mark - <YUIViewModelDelegate>

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{
    
    if(self.architectureDelegate && [self.architectureDelegate respondsToSelector:@selector(viewModel:withInfo:)]){
        
        [self.architectureDelegate viewModel:viewModel withInfo:info];
    }
}

- (ComnonArchitectureDelegateObject *)architectureDelegate{
    
    if(!_architectureDelegate){
        
        _architectureDelegate = [ComnonArchitectureDelegateObject new];
        _architectureDelegate.delegate = self;
    }
    return _architectureDelegate;
}

@end
