//
//  YUIViewManager+Common.m
//  YUIAll
//
//  Created by YUI on 2021/5/20.
//

#import "YUIViewManager+Common.h"
#import <objc/runtime.h>

#import "ComnonArchitectureDelegateObject.h"

@interface YUIViewManager (Common)

@property (nonatomic, strong) ComnonArchitectureDelegateObject *architectureDelegateObject;

@end

@implementation YUIViewManager (Common)

#pragma mark - <YUIViewDelegate>

//既然使用dict作为信息转递决定具体的操作，我在中层添加了一种集约型模式转换为离散型模式的一种可能，并且以此弱化硬编码，优化上层判断
- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{
    
    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(view:withEvent:)]){
        
        [self.architectureDelegateObject view:view withEvent:event];
    }
}

#pragma mark - <YUIViewModelDelegate>

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{
    
    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(viewModel:withInfo:)]){
        
        [self.architectureDelegateObject viewModel:viewModel withInfo:info];
    }
}

- (ComnonArchitectureDelegateObject *)architectureDelegateObject{
    
    ComnonArchitectureDelegateObject *architectureDelegateObject = objc_getAssociatedObject(self, _cmd);
    
    if(!architectureDelegateObject){
        architectureDelegateObject = [ComnonArchitectureDelegateObject new];
        architectureDelegateObject.delegate = self;
        [self setArchitectureDelegateObject:architectureDelegateObject];
    }
    
    return architectureDelegateObject;
}

- (void)setArchitectureDelegateObject:(ComnonArchitectureDelegateObject *)architectureDelegateObject{
    
    objc_setAssociatedObject(self, @selector(architectureDelegateObject), architectureDelegateObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
