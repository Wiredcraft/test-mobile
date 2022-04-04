//
//  YUIViewManager.h
//  YUIAll
//
//  Created by YUI on 2021/2/21.
//

#import <Foundation/Foundation.h>

#import "YUIViewManagerProtocol.h"
#import "YUIViewDelegateProtocol.h"
#import "YUIViewModelDelegateProtocol.h"
#import "YUIViewProtocol.h"
#import "YUIViewManagerDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIViewManager : NSObject <YUIViewManagerProtocol,YUIViewDelegateProtocol,YUIViewModelDelegateProtocol>

@property (nonatomic, weak) UIView *managerView;

@property (nonatomic, weak) UIViewController *viewController;

@property (nullable, nonatomic, weak) id<YUIViewManagerDelegateProtocol> viewManagerDelegate;

/**
 *  ViewManagerInfoBlock
 */
@property (nonatomic, copy) ViewManagerInfoBlock viewManagerInfoBlock;

/**
 *  viewManagerInfo
 */
@property (nonatomic, copy) NSDictionary *viewManagerInfo;

@end

NS_ASSUME_NONNULL_END
