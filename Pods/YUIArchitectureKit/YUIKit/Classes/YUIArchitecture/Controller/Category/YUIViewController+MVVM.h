//
//  YUIViewController+MVVM.h
//  YUIAll
//
//  Created by YUI on 2020/12/14.
//

#import "YUIViewController.h"

#import "YUIViewProtocol.h"
#import "YUIViewModelProtocol.h"
#import "YUIViewManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIViewController (){
    
    id <YUIViewModelProtocol> _viewModel;
    id <YUIViewManagerProtocol> _viewManager;
}

@property (nonatomic, strong) id<YUIViewModelProtocol> viewModel;
@property (nonatomic, strong) id<YUIViewManagerProtocol> viewManager;

@end

@interface YUIViewController (MVVM)<YUIViewModelDelegateProtocol>

@end

NS_ASSUME_NONNULL_END
