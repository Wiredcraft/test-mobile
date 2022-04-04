//
//  YUIModelManager.m
//  YUIAll
//
//  Created by YUI on 2018/12/3.
//  Copyright © 2018年 YUI. All rights reserved.
//

#import "YUIModelManager.h"

@interface YUIModelManager ()

@end

@implementation YUIModelManager

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

#pragma mark - Data Interaction

//  从本地或服务器加载数据Model
- (void)loadData:(nullable id)parameter{

    // Rewrite this func in SubClass !
}

//  赋值至ModelManagar,作为通用赋值传值接口
- (void)setData:(id)parameter{
    
    // Rewrite this func in SubClass !
}

//  从本类取值，作为通用接口
- (nullable id)getData:(id)parameter{
    
    return nil;
}

//  Model上传至服务器
- (void)uploadData:(nullable id)parameter{

    // Rewrite this func in SubClass !
}

//  从服务器下载数据
- (void)downloadData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//  Model保存数据至服务器或本地
- (void)saveData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//  处理数据
- (void)processData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//  刷新数据
- (void)refreshData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//  重置数据
- (void)restoreData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//  释放数据
- (void)releaseData:(nullable id)parameter{
    
    // Rewrite this func in SubClass !
}

//- (nullable NSDictionary *)allPropertiesKey {
//
//    unsigned int count = 0;
//
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    NSMutableDictionary *resultDict = [@{} mutableCopy];
//
//    for (NSUInteger i = 0; i < count; i ++) {
//
//        const char *propertyName = property_getName(properties[i]);
//        NSString *name = [NSString stringWithUTF8String:propertyName];
//        id propertyValue = [self valueForKey:name];
//
//        if (propertyValue) {
//            resultDict[name] = propertyValue;
//        } else {
//            resultDict[name] = @"字典的key对应的value不能为nil";
//        }
//    }
//
//    free(properties);
//
//    return resultDict;
//}

#pragma Data Callbacks

@end
