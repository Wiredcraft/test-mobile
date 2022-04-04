//
//  CommonViewController.m
//  YUIAll
//
//  Created by YUI on 2020/11/17.
//

#import "CommonViewController.h"

#import "QMUICore.h"
#import "QMUINavigationTitleView.h"
#import "QMUIEmptyView.h"
#import "NSString+QMUI.h"
#import "NSObject+QMUI.h"
#import "UIViewController+QMUI.h"
#import "UIGestureRecognizer+QMUI.h"
#import "UIView+QMUI.h"

#import "CommonViewController+EmptyView.h"
#import "CommonViewController+PopupView.h"
#import "CommonViewController+SubclassingHooks.h"

@interface CommonViewControllerHideKeyboardDelegateObject : NSObject <UIGestureRecognizerDelegate, QMUIKeyboardManagerDelegate>

@property(nonatomic, weak) CommonViewController *viewController;

- (instancetype)initWithViewController:(CommonViewController *)viewController;
@end

@interface CommonViewController () {
    UITapGestureRecognizer *_hideKeyboardTapGestureRecognizer;
    QMUIKeyboardManager *_hideKeyboardManager;
    CommonViewControllerHideKeyboardDelegateObject *_hideKeyboadDelegateObject;
}

@property(nonatomic,strong,readwrite) QMUINavigationTitleView *titleView;
@end

@implementation CommonViewController

#pragma mark - 生命周期

- (void)didInitialize {
    
    [super didInitialize];
    
    self.titleView = [[QMUINavigationTitleView alloc] init];
    self.titleView.title = self.title;// 从 storyboard 初始化的话，可能带有 self.title 的值
    self.navigationItem.titleView = self.titleView;
    
    // 不管navigationBar的backgroundImage如何设置，都让布局撑到屏幕顶部，方便布局的统一
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.supportedOrientationMask = SupportedOrientationMask;
    
    if (QMUICMIActivated) {
        self.hidesBottomBarWhenPushed = HidesBottomBarWhenPushedInitially;
        self.qmui_preferredStatusBarStyleBlock = ^UIStatusBarStyle{
            return StatusbarStyleLightInitially ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
        };
    }
    
    if (@available(iOS 11.0, *)) {
        self.qmui_prefersHomeIndicatorAutoHiddenBlock = ^BOOL{
            return NO;
        };
    }

    // 动态字体notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeCategoryDidChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    if (!self.view.backgroundColor && QMUICMIActivated) {// nib 里可能设置了，所以做个 if 的判断
        self.view.backgroundColor = UIColorForBackground;
    }
    
    // 点击空白区域降下键盘 CommonViewController (QMUIKeyboard)
    // 如果子类重写了才初始化这些对象（即便子类 return NO）
    BOOL shouldEnabledKeyboardObject = [self qmui_hasOverrideMethod:@selector(shouldHideKeyboardWhenTouchInView:) ofSuperclass:[CommonViewController class]];
    if (shouldEnabledKeyboardObject) {
        _hideKeyboadDelegateObject = [[CommonViewControllerHideKeyboardDelegateObject alloc] initWithViewController:self];
        
        _hideKeyboardTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:NULL];
        self.hideKeyboardTapGestureRecognizer.delegate = _hideKeyboadDelegateObject;
        self.hideKeyboardTapGestureRecognizer.enabled = NO;
        [self.view addGestureRecognizer:self.hideKeyboardTapGestureRecognizer];
        
        _hideKeyboardManager = [[QMUIKeyboardManager alloc] initWithDelegate:_hideKeyboadDelegateObject];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // fix iOS 11 and later, shouldHideKeyboardWhenTouchInView: will not work when calling becomeFirstResponder in UINavigationController.rootViewController.viewDidLoad
    // https://github.com/Tencent/QMUI_iOS/issues/495
    if (@available(iOS 11.0, *)) {
        if (self.hideKeyboardManager && [QMUIKeyboardManager isKeyboardVisible]) {
            self.hideKeyboardTapGestureRecognizer.enabled = YES;
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutEmptyView];
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.supportedOrientationMask;
}

@end

@implementation CommonViewController (QMUINavigationController)

- (void)updateNavigationBarAppearance {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) return;
    
    if ([self respondsToSelector:@selector(qmui_navigationBarBackgroundImage)]) {
        [navigationBar setBackgroundImage:[self qmui_navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    }
    if ([self respondsToSelector:@selector(qmui_navigationBarBarTintColor)]) {
        navigationBar.barTintColor = [self qmui_navigationBarBarTintColor];
    }
    if ([self respondsToSelector:@selector(qmui_navigationBarStyle)]) {
        navigationBar.barStyle = [self qmui_navigationBarStyle];
    }
    if ([self respondsToSelector:@selector(qmui_navigationBarShadowImage)]) {
        navigationBar.shadowImage = [self qmui_navigationBarShadowImage];
    }
    if ([self respondsToSelector:@selector(qmui_navigationBarTintColor)]) {
        navigationBar.tintColor = [self qmui_navigationBarTintColor];
    }
    if ([self respondsToSelector:@selector(qmui_titleViewTintColor)]) {
        self.titleView.tintColor = [self qmui_titleViewTintColor];
    }
}

#pragma mark - <QMUINavigationControllerDelegate>

- (BOOL)preferredNavigationBarHidden {
    return NavigationBarHiddenInitially;
}

- (void)viewControllerKeepingAppearWhenSetViewControllersWithAnimated:(BOOL)animated {
    // 通常和 viewWillAppear: 里做的事情保持一致
    [self setupNavigationItems];
    [self setupToolbarItems];
}

@end

@implementation CommonViewController (QMUIKeyboard)

- (UITapGestureRecognizer *)hideKeyboardTapGestureRecognizer {
    return _hideKeyboardTapGestureRecognizer;
}

- (QMUIKeyboardManager *)hideKeyboardManager {
    return _hideKeyboardManager;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    // 子类重写，默认返回 NO，也即不主动干预键盘的状态
    return NO;
}

@end

@implementation CommonViewControllerHideKeyboardDelegateObject

- (instancetype)initWithViewController:(CommonViewController *)viewController {
    if (self = [super init]) {
        self.viewController = viewController;
    }
    return self;
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer != self.viewController.hideKeyboardTapGestureRecognizer) {
        return YES;
    }
    
    if (![QMUIKeyboardManager isKeyboardVisible]) {
        return NO;
    }
    
    UIView *targetView = gestureRecognizer.qmui_targetView;
    
    // 点击了本身就是输入框的 view，就不要降下键盘了
    if ([targetView isKindOfClass:[UITextField class]] || [targetView isKindOfClass:[UITextView class]]) {
        return NO;
    }
    
    if ([self.viewController shouldHideKeyboardWhenTouchInView:targetView]) {
        [self.viewController.view endEditing:YES];
    }
    return NO;
}

#pragma mark - <QMUIKeyboardManagerDelegate>

- (void)keyboardWillShowWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    if (![self.viewController qmui_isViewLoadedAndVisible]) return;
    self.viewController.hideKeyboardTapGestureRecognizer.enabled = YES;
}

- (void)keyboardWillHideWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    self.viewController.hideKeyboardTapGestureRecognizer.enabled = NO;
}

@end
