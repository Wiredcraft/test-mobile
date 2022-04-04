//
//  ApplicationMediator.h
//  QiShiMaiTour
//
//  Created by 蒋来 on 2019/12/3.
//  Copyright © 2019 蒋来. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppLifeCycleMediatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kModulesRegisterFileName;

@interface AppLifeCycleMediator : NSObject<AppLifeCycleMediatorProtocol>

+ (instancetype)sharedInstance;

- (void)loadModules;

- (void)loadModulesWithPlistFilePath:(NSString *)plistFilePath;

- (NSArray<id<AppLifeCycleMediatorProtocol>> *)allModules;

@end

NS_ASSUME_NONNULL_END
