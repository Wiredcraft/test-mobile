//
//  NSObject+YUIViewManager.h
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import <Foundation/Foundation.h>
#import "YUIViewDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ViewEventBlock)(void);

@interface NSObject (YUIViewManager)

/**
 *  viewDelegate 传递事件
 */
@property (nullable, nonatomic, weak) id<YUIViewDelegateProtocol> viewDelegate;

/**
 *  block 传递事件
 */
@property (nonatomic, copy) ViewEventBlock viewEventBlock;

/**
 *  将view中的事件交由viewManager处理
 */
-(void)viewWithViewManager:(id<YUIViewDelegateProtocol>)viewManager;

@end

NS_ASSUME_NONNULL_END
