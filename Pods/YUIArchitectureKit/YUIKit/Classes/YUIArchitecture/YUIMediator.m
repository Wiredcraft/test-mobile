//
//  YUIMediator.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/15.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "YUIMediator.h"

#import "YUIViewModel.h"
#import "YUIViewManager.h"

@implementation YUIMediator

- (instancetype)initWithViewModel:(id<YUIViewModelProtocol>)viewModel viewManager:(id<YUIViewManagerProtocol>)viewManager {
    if (self = [super init]) {
        self.viewModel = (NSObject<YUIViewModelProtocol> *)viewModel;
        self.viewManager = (NSObject<YUIViewManagerProtocol> *)viewManager;
    }
    return self;
}

+ (instancetype)mediatorWithViewModel:(id<YUIViewModelProtocol>)viewModel viewManager:(id<YUIViewManagerProtocol>)viewManager {
    return [[self alloc]initWithViewModel:viewModel viewManager:viewManager];
}

- (void)noticeViewModelWithInfo:(NSDictionary *)info {
    
    if([self.viewModel isKindOfClass:[YUIViewModel class]]){
        
        [(YUIViewModel *)self.viewModel setViewModelInfo:info];
    }
}

- (void)noticeViewManagerWithInfo:(NSDictionary *)info {
    
    if([self.viewManager isKindOfClass:[YUIViewManager class]]){
        
        [(YUIViewManager *)self.viewManager setViewManagerInfo:info];
    }
}

@end
