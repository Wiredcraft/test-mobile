//
//  YUIMediator.h
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/15.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUIViewModelProtocol.h"
#import "YUIViewManagerProtocol.h"

@interface YUIMediator : NSObject

/**
 *  viewModel
 */
@property (nonatomic, strong) id<YUIViewModelProtocol> viewModel;

/**
 *  viewManager
 */
@property (nonatomic, strong) id<YUIViewManagerProtocol> viewManager;

/**
 *  初始化
 */
- (instancetype)initWithViewModel:(id<YUIViewModelProtocol>)viewModel viewManager:(id<YUIViewManagerProtocol>)viewManager;

+ (instancetype)mediatorWithViewModel:(id<YUIViewModelProtocol>)viewModel viewManager:(id<YUIViewManagerProtocol>)viewManager;

/**
 *  将info通知viewModel
 */
- (void)noticeViewModelWithInfo:(NSDictionary *)info;

/**
 *  将info通知viewMnager
 */
- (void)noticeViewManagerWithInfo:(NSDictionary *)info;

@end
