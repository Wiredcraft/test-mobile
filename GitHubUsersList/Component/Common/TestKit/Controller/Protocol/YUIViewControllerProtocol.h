//
//  YUIViewControllerProtocol.h
//  YUIAll
//
//  Created by YUI on 2020/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIViewControllerProtocol <NSObject>

@optional

/// 单例模式
+ (instancetype)sharedInstance;

/// 用于对应单例模式释放
-(void)clear;


/**
 *  初始化时调用的方法，会在两个 NS_DESIGNATED_INITIALIZER 方法中被调用，所以子类如果需要同时支持两个 NS_DESIGNATED_INITIALIZER 方法，则建议把初始化时要做的事情放到这个方法里。否则仅需重写要支持的那个 NS_DESIGNATED_INITIALIZER 方法即可。
 */
-(void)didInitialize;

/// 用于绑定应用架构模式（Architectural Pattern）
-(void)configureArchitecturalPattern;

/// 用于配置组件并且在 viewDidLoad 与 viewWillAppear: 都会调用
-(void)configureComponent;

/// 用于对应setup中的释放
-(void)clean;

#pragma mark View

-(void)configureNavigationBar;
-(void)configureTabBar;

-(void)configureMainView;
-(void)configureSubview;

-(void)configureSubviewLayout;
-(void)updateSubviewLayout;

/// 更新子视图
-(void)updateSubview;

/// 重置子视图
-(void)restoreSubview;

/// 移除子视图
-(void)removeSubView;

/// 配置手势
-(void)configureGesture;

/**
 更新手势
 
 在SubView会因为updateSubview更新约束的时候使用的用于更新手势的方法
 */
-(void)updateGesture;

/// 设置刷新
-(void)configureRefresh;

#pragma mark Model

/**
从界面获取数据至Model
*/
-(void)getData;

/**
从Model将数据设置于界面
*/
-(void)setData;

/**
从Model将数据更新于界面
*/
-(void)updateData;


///从本地或服务器加载数据Model
-(void)loadData;

///Model上传至服务器
-(void)uploadData;

///Model保存数据至服务器或本地
-(void)saveData;

///处理数据
-(void)processData;

///重置数据
-(void)restoreData;

///释放数据
-(void)releaseData;


@end

NS_ASSUME_NONNULL_END
