//
//  YUIViewController+YUISubclassingHooks.h
//  YUIAll
//
//  Created by YUI on 2021/2/4.
//

#import "YUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIViewController (YUISubclassingHooks)

#pragma mark - Architecture

#pragma mark - <YUIViewControllerProtocol>

/////  负责初始化设计架构，并且绑定
//- (void)configureArchitecture;
//
/////  负责绑定各控制层，如viewModel层与View层之间的绑定，绑定包括属性、代理以及中介者形式。
//- (void)configureBingding NS_REQUIRES_SUPER;


#pragma mark - Init

//- (void)didInitialize NS_REQUIRES_SUPER;


#pragma mark - UI

#pragma mark - <YUIViewProtocol>

//// 负责设置self.view，某些解耦方案中会直接替换self.view。
- (void)setupMainView NS_REQUIRES_SUPER;

/**
 *  负责初始化和设置controller里面的view，也就是self.view的subView。目的在于分类代码，所以与view初始化的相关代码都写在这里。
 *
 *  @warning initSubviews只负责subviews的init，不负责布局。布局相关的代码应该写在 <b>viewDidLayoutSubviews</b>。
 */
- (void)initSubviews NS_REQUIRES_SUPER;

///  负责subviews使用setFrame布局
- (void)setupSubviewsFrame NS_REQUIRES_SUPER;

///  负责subviews使用layout布局
- (void)setupSubviewsConstraints NS_REQUIRES_SUPER;

///  负责配置手势
- (void)configureGesture;

///  负责更新视图
- (void)updateSubviews;

///  负责更新视图布局
- (void)updateSubviewsLayout;


#pragma mark - <YUIViewControllerProtocol>

/**
 *  负责设置和更新navigationItem，包括title、leftBarButtonItem、rightBarButtonItem。viewWillAppear 里面会自动调用，业务也可以在需要的时候自行调用。目的在于分类代码，所有与navigationItem相关的代码都写在这里。在需要修改navigationItem的时候都统一调用这个接口。
 */
- (void)setupNavigationItems NS_REQUIRES_SUPER;

/**
 *  负责设置和更新toolbarItem。在viewWillAppear里面自动调用（因为toolbar是navigationController的，是每个界面公用的，所以必须在每个界面的viewWillAppear时更新，不能放在viewDidLoad里），允许手动调用。目的在于分类代码，所有与toolbarItem相关的代码都写在这里。在需要修改toolbarItem的时候都只调用这个接口。
 */
- (void)setupToolbarItems NS_REQUIRES_SUPER;

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
- (void)configureObserver NS_REQUIRES_SUPER;

///  清理KVO，一般在<b>dealloc</b>中调用。
- (void)cleanupObserver NS_REQUIRES_SUPER;

///  负责配置Notification，<b>viewWillAppear</b>的时候进行addNotification，在<b>viewWillDisappear</b>时removeNotification，这样可以保证add和remove是成对出现的，是一种比较理想的使用方式。
///  或者在<b>init</b>时调用，对于viewController现在系统会<b>dealloc</b>调用清理。
//- (void)configureNotification NS_REQUIRES_SUPER;

///  负责删除Notification，<b>viewWillAppear</b>的时候进行addNotification，在<b>viewWillDisappear</b>时removeNotification，这样可以保证add和remove是成对出现的，是一种比较理想的使用方式。
- (void)removeNotification NS_REQUIRES_SUPER;

///  清理通知，一般在<b>dealloc</b>中调用，现在的系统会在delloc自动调用removeNotification。
//- (void)cleanupNotification;

///  负责配置Timer
- (void)configureTimer;

///  负责无效化Timer，一般在<b>viewWillDisappear</b>中调用。
- (void)cleanupTimer NS_REQUIRES_SUPER;


#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;


#pragma mark - <YUIViewDelegateProtocol>

- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event;


#pragma mark - <YUIViewModelDelegateProtocol>

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
