//
//  YUIViewModelSubclassingHooksProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "YUIModelManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  请求成功block
 */
typedef void (^successBlock)(id responseObject);
/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError *error);
/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);
/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);
/**
 *  将自己的信息返回给ViewManager的block
 */
typedef void (^ViewManagerInfoBlock)(void);
/**
 *  将自己的信息返回给ViewModel的block
 */
typedef void (^ViewModelInfoBlock)(void);

@protocol YUIViewModelProtocol <YUIModelManagerProtocol>

@optional

- (void)notice;

/**
 *  返回指定viewModel的所引用的控制器
 */
- (void)viewModelWithViewController:(UIViewController *)viewController;

/**
 *  加载数据
 */
- (NSURLSessionTask *)viewModelWithProgress:(nullable progressBlock)progress success:(nullable successBlock)success failure:(nullable failureBlock)failure;

/**
 *  传递模型给view
 */
- (void)viewModelWithModelBlcok:(void (^)(id model))modelBlock;

/**
 *  处理ViewManagerInfoBlock
 */
- (ViewManagerInfoBlock)viewModelWithViewManagerBlockOfInfo:(NSDictionary *)info;

/**
 *  处理ViewModelInfoBlock
 */
- (ViewModelInfoBlock)viewModelWithOtherViewModelBlockOfInfo:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
