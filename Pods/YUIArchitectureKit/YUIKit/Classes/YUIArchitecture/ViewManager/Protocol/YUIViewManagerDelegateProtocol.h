//
//  YUIViewManagerProtocol.h
//  YUIAll
//
//  Created by YUI on 2020/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIViewManagerDelegateProtocol <NSObject>

@optional

/**
 *  将viewManager中的信息通过代理传递给ViewModel
 *
 *  @param viewManager   viewManager自己
 *  @param info 描述信息
 */
- (void)viewManager:(id)viewManager withInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
