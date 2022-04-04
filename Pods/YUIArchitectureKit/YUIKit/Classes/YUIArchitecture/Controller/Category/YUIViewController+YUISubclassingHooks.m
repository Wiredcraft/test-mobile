//
//  YUIViewController+YUISubclassingHooks.m
//  YUIAll
//
//  Created by YUI on 2021/2/4.
//

#import "YUIViewController+YUISubclassingHooks.h"

@implementation YUIViewController (YUISubclassingHooks)

#pragma mark - <YUIViewControllerProtocol>

//- (void)configureArchitecture{
//
//    [self executeMethodFromArchitecture:_cmd];
//}
//
//- (void)configureBingding{
//
//    [self executeMethodFromArchitecture:_cmd];
//}

//- (void)didInitialize {
//    
//    self.dataLoadType = DataLoadTypeCustom;
//    self.isFirstAppear = YES;
//    
//    [self configureNotification];
//    
//    [self executeMethodFromArchitecture:_cmd];
//}

#pragma mark - <YUIViewProtocol>

- (void)setupMainView{
    // Rewrite this func in SubClass !
}

- (void)initSubviews {
    // Rewrite this func in SubClass !
}

- (void)setupSubviewsFrame{
    // Rewrite this func in SubClass !
}

- (void)setupSubviewsConstraints{
    // Rewrite this func in SubClass !
}

- (void)configureGesture{
    // Rewrite this func in SubClass !
}

- (void)updateSubviews{
    // Rewrite this func in SubClass !
}

- (void)updateSubviewsLayout{
    // Rewrite this func in SubClass !
}

- (void)setupNavigationItems {
    // Rewrite this func in SubClass !
}

- (void)setupToolbarItems {
    // Rewrite this func in SubClass !
}

- (void)contentSizeCategoryDidChanged:(NSNotification *)notification {
    // Rewrite this func in SubClass !
}

- (void)configureObserver{
    // Rewrite this func in SubClass !
}

- (void)cleanupObserver{
    // Rewrite this func in SubClass !
}

//- (void)configureNotification{
    // Rewrite this func in SubClass !
//}

- (void)removeNotification{
    // Rewrite this func in SubClass !
}

//- (void)cleanupNotification{
//   
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}

- (void)configureTimer{
    // Rewrite this func in SubClass !
}

- (void)cleanupTimer{
    // Rewrite this func in SubClass !
}

#pragma mark - <YUIViewControllerDelegateProtocol>

- (void)viewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
}

#pragma mark - <YUIViewDelegateProtocol>

- (void)view:(__kindof UIView *)view withEvent:(NSDictionary *)event{
    
}

#pragma mark - <YUIViewModelDelegateProtocol>

- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info{
    
}

@end
