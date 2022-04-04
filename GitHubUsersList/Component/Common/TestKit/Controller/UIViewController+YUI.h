//
//  UIViewController+YUI.h
//  YUIAll
//
//  Created by YUI on 2020/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (YUI)

+ (instancetype)sharedInstance;
/**
 用于对应单例模式释放
 */
- (void)clear;

- (void)commonInit;
- (void)setup;
/**
 用于对应setup中的释放
 */
- (void)clean;

#pragma make View

- (void)configureNavigationBar;
- (void)configureTabBar;

- (void)configureMainView;
- (void)configureSubview;

- (void)configureSubviewLayout;
- (void)updateSubviewLayout;

/// 更新子视图
- (void)updateSubview;

/// 重置子视图
- (void)restoreSubview;

/// 移除子视图
- (void)removeSubView;

/// 配置手势
- (void)configureGesture;

/**
 更新手势
 
 在SubView会因为updateSubview更新约束的时候使用的用于更新手势的方法
 */
- (void)updateGesture;

/// 设置刷新
- (void)configureRefresh;

#pragma make Model

/**
从界面获取数据至Model
*/
- (void)getData;

/**
从Model将数据设置于界面
*/
- (void)setData;

/**
从Model将数据更新于界面
*/
- (void)updateData;


///从本地或服务器加载数据Model
- (void)loadData;

///Model上传至服务器
- (void)uploadData;

///Model保存数据至服务器或本地
- (void)saveData;

///处理数据
- (void)processData;

///重置数据
- (void)restoreData;

///释放数据
- (void)releaseData;

@end

NS_ASSUME_NONNULL_END
