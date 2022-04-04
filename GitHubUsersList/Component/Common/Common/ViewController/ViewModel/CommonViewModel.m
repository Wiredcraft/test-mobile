//
//  CommonViewModel.m
//  YUIAll
//
//  Created by YUI on 2021/5/17.
//

#import "CommonViewModel.h"

#import "NetworkKit.h"
#import  <YYModel.h>

#import "ComnonArchitectureDelegateObject.h"

@interface CommonViewModel ()

@property (nonatomic, strong) ComnonArchitectureDelegateObject *architectureDelegateObject;

@end

@implementation CommonViewModel

#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)setData:(id)parameter{
    
    if(parameter && [parameter isKindOfClass:[NSDictionary class]]){
        
        [self yy_modelSetWithDictionary:parameter];
    }
}

#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(viewController:withInfo:)]){
        
        [self.architectureDelegateObject viewController:viewController withInfo:info];
    }
}

#pragma mark - <YUIViewManagerDelegate>

- (void)viewManager:(id)viewManager withInfo:(NSDictionary *)info{
    
    if(self.architectureDelegateObject && [self.architectureDelegateObject respondsToSelector:@selector(viewManager:withInfo:)]){
        
        [self.architectureDelegateObject viewManager:viewManager withInfo:info];
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
