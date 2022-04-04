//
//  ApplicationMediator.m
//  QiShiMaiTour
//
//  Created by 蒋来 on 2019/12/3.
//  Copyright © 2019 蒋来. All rights reserved.
//

#import "AppLifeCycleMediator.h"

@interface AppLifeCycleMediator ()<UIApplicationDelegate, UISceneDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSMutableArray<id<AppLifeCycleMediatorProtocol>> *modules;

@end

@implementation AppLifeCycleMediator

NSString * const kModulesRegisterFileName = @"ModulesRegister";

+ (instancetype)sharedInstance{
    
    static AppLifeCycleMediator *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (NSMutableArray<id<AppLifeCycleMediatorProtocol>> *)modules{
    
    if (!_modules) {
        
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (void)loadModules{
    
    NSString *plistFilePath = [[NSBundle mainBundle]pathForResource:kModulesRegisterFileName ofType:@"plist"];
    
    [self loadModulesWithPlistFilePath:plistFilePath];
}

- (void)loadModulesWithPlistFilePath:(NSString *)plistFilePath{
    
    NSArray<NSString *> *moduleNames = [NSArray arrayWithContentsOfFile:plistFilePath];
    
    for (NSString *moduleName in moduleNames) {
        
        id<AppLifeCycleMediatorProtocol> module = [[NSClassFromString(moduleName) alloc] init];
        
        [self addModule:module];
    }
}

- (void)addModule:(id<AppLifeCycleMediatorProtocol>)module{
    
    if (![self.modules containsObject:module]) {
        
        [self.modules addObject:module];
    }
}

- (NSArray<id<AppLifeCycleMediatorProtocol>> *)allModules{
    
    return self.modules;
}

#pragma mark - State Transitions / Launch time:

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    BOOL result;

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:&result arguments: &application, &launchOptions, nil];

    return result;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    BOOL result;

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:&result arguments: &application, &launchOptions, nil];

    return YES;
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidBecomeActive:(UIApplication *)application{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, nil];
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidEnterBackground:(UIApplication *)application{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, nil];
}

#pragma mark - State Transitions / Transitioning to the inactive state:

// Called when leaving the foreground state.
- (void)applicationWillResignActive:(UIApplication *)application{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, nil];
}

// Called when transitioning out of the background state.
- (void)applicationWillEnterForeground:(UIApplication *)application{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, nil];
}

#pragma mark - State Transitions / Termination:

- (void)applicationWillTerminate:(UIApplication *)application{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, nil];
}

#pragma mark - Handling Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, &deviceToken, nil];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, &error, nil];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;{

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &application, &userInfo, &completionHandler, nil];
}

#pragma mark - Handling Local Notification

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            if (@available(iOS 10.0, *)) {
                [module userNotificationCenter:center
                       willPresentNotification:notification
                         withCompletionHandler:completionHandler];
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center
            didReceiveNotificationResponse:response
                     withCompletionHandler:completionHandler];
        }
    }
}

#pragma mark - Handling Continuing User Activity and Handling Quick Actions

- (BOOL)application:(UIApplication *)application
willContinueUserActivityWithType:(NSString *)userActivityType{
    BOOL result = NO;
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            result = result || [module application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application
continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    BOOL result = NO;
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            result = result || [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return result;
}

- (void)application:(UIApplication *)application
didUpdateUserActivity:(NSUserActivity *)userActivity{
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application
didFailToContinueUserActivityWithType:(NSString *)userActivityType
              error:(NSError *)error{
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void (^)(BOOL succeeded))completionHandler{
    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {

        if ([module respondsToSelector:_cmd]) {

            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

#pragma mark - <UISceneDelegate>

-(void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, &session, &connectionOptions, nil];
}

- (void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, nil];
}

- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, nil];
}

- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, nil];
}

- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, nil];
}

- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0)){

    [self performSelectorForModules:_cmd withPrimitiveReturnValue:nil arguments: &scene, nil];
}

- (void)performSelectorForModules:(SEL)selector withPrimitiveReturnValue:(nullable void *)returnValue arguments:(nullable void *)firstArgument, ...{

    for (id<AppLifeCycleMediatorProtocol> module in self.modules) {

        if ([module isKindOfClass:[NSObject class]] && [module respondsToSelector:selector]) {

            [(NSObject *)module qmui_performSelector:selector withPrimitiveReturnValue:returnValue arguments:firstArgument, nil];
        }
    }
}

@end
