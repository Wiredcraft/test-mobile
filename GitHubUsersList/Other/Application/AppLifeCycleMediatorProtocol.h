//
//  AppLifeCycleMediatorProtocol.h
//  YUIAll
//
//  Created by YUI on 2022/2/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AppLifeCycleMediatorProtocol <UIApplicationDelegate, UNUserNotificationCenterDelegate, UISceneDelegate>

@end

NS_ASSUME_NONNULL_END
