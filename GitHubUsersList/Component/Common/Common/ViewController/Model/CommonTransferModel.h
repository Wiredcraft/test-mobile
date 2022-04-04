//
//  CommonTransferModel.h
//  YUIAll
//
//  Created by YUI on 2021/5/17.
//

#import "YUIModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonTransferModel : YUIModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, copy) NSArray <UIView *> *views;
@property (nonatomic, strong) id<NSObject> index;
@property (nonatomic, strong) id<NSObject> data;
@property (nonatomic, strong) id<YUIModelManagerProtocol> modelManager;
@property (nonatomic, strong) id<YUIViewModelProtocol> viewModel;
@property (nonatomic, strong) id<YUIViewControllerProtocol> viewController;

@end

NS_ASSUME_NONNULL_END
