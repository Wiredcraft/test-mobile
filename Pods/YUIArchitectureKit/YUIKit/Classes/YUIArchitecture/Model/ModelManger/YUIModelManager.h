//
//  YUIModelManager.h
//  YUIAll
//
//  Created by YUI on 2018/12/3.
//  Copyright © 2018年 YUI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YUIModelManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIModelManager : NSObject<YUIModelManagerProtocol>

///负责表示数据加载已经完成 请在你的数据加载完成时手动修改这个属性为 YES。
@property(nonatomic, assign, getter = isDataLoaded) BOOL dataDidLoad;

@end

NS_ASSUME_NONNULL_END
