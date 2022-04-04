//
//  YUIViewModelProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIViewModelDelegateProtocol <NSObject>

@optional

/**
 *  将viewModel中的信息通过代理传递给ViewManager
 *
 *  @param viewModel   viewModel自己
 *  @param info 描述信息
 */
- (void)viewModel:(id)viewModel withInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
