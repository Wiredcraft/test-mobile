//
//  CommonModelManager.h.m
//  YUIAll
//
//  Created by YUI on 2018/12/18.
//  Copyright © 2018年 YUI. All rights reserved.
//

#import "CommonModelManager.h"

#import "NetworkKit.h"
#import  <YYModel.h>

@interface CommonModelManager ()<NetworkKitDelegate>

@end

@implementation CommonModelManager

- (void)didInitialize{
    
}

- (void)setup{
    
    [NetworkKit sharedInstance].delegate = self;
}

#pragma mark - Data Interaction

- (void)setData:(id)parameter{
    
    if(parameter && [parameter isKindOfClass:[NSDictionary class]]){
        
        [self yy_modelSetWithDictionary:parameter];
    }
}

#pragma Data Callback

- (void)requestSuccessHandlerResult:(id)result{
    
}

- (void)requestFailedHandlerResult:(id)result{
    
}

- (void)requestFinishedHandlerResult:(id)result{
    
}

@end
