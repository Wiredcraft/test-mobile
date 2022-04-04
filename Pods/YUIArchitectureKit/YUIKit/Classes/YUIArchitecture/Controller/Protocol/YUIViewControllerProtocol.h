//
//  YUIViewControllerSubclassingHooksProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIViewControllerProtocol <NSObject>

@optional

#pragma mark - Architecture

///  负责初始化设计架构，并且尝试创建、绑定上层应用架构部件
- (void)configureArchitecture;

- (void)configureBingding;


#pragma mark - Init

- (void)didInitialize;


#pragma mark - UI

/**
 *  负责设置和更新navigationItem，包括title、leftBarButtonItem、rightBarButtonItem。viewWillAppear 里面会自动调用，业务也可以在需要的时候自行调用。目的在于分类代码，所有与navigationItem相关的代码都写在这里。在需要修改navigationItem的时候都统一调用这个接口。
 */
- (void)setupNavigationItems;

/**
 *  负责设置和更新toolbarItem。在viewWillAppear里面自动调用（因为toolbar是navigationController的，是每个界面公用的，所以必须在每个界面的viewWillAppear时更新，不能放在viewDidLoad里），允许手动调用。目的在于分类代码，所有与toolbarItem相关的代码都写在这里。在需要修改toolbarItem的时候都只调用这个接口。
 */
- (void)setupToolbarItems;

/**
 *  动态字体的回调函数。
 *
 *  交给子类重写，当系统字体发生变化的时候，会调用这个方法，一些font的设置或者reloadData可以放在里面。
 *
 *  @param notification test
 */
- (void)contentSizeCategoryDidChanged:(NSNotification *)notification;


#pragma mark - Supplementary

/// 负责配置KVO，比如Model链接Controller，苹果官方推荐的方式是，在<b>init</b>的时候进行addObserver，在<b>dealloc</b>时removeObserver，这样可以保证add和remove是成对出现的，是一种比较理想的使用方式。
- (void)configureObserver;

///  清理KVO，一般在<b>dealloc</b>中调用。
- (void)cleanupObserver;

///  负责配置Notification，<b>viewWillAppear</b>的时候进行addNotification，在<b>viewWillDisappear</b>时removeNotification，这样可以保证add和remove是成对出现的，是一种比较理想的使用方式。
///  或者在<b>init</b>时调用，对于viewController现在系统会在<b>dealloc</b>调用清理。
- (void)configureNotification;

///  负责删除Notification，<b>viewWillAppear</b>的时候进行addNotification，在<b>viewWillDisappear</b>时removeNotification，这样可以保证add和remove是成对出现的，是一种比较理想的使用方式。
- (void)removeNotification;

///  清理通知，一般在<b>dealloc</b>中调用，对于viewController现在系统会在<b>dealloc</b>调用清理。
- (void)cleanupNotification;

///  负责配置Timer
- (void)configureTimer;

///  负责无效化Timer，一般在<b>viewWillDisappear</b>中调用。
- (void)cleanupTimer;


@end

NS_ASSUME_NONNULL_END
