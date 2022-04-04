//
//  YUIViewManagerSubclassingHooksProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ViewEventBlock)(void);

/**
 *  将自己的信息返回给ViewModel的block
 */
typedef void (^ViewModelInfoBlock)(void);

/**
 *  将自己的信息返回给ViewManager的block
 */
typedef void (^ViewManagerInfoBlock)(void);


@protocol YUIViewManagerProtocol <NSObject>

@optional

#pragma mark -- init

- (void)didInitialize;

- (void)notice;

/**
 *  返回viewManager所管理的视图
 *
 *  @return viewManager所管理的视图
 */
- (__kindof UIView *)viewManagerOfManagerView;

/**
 *  设置Controller的子视图的管理者为self
 *
 *  @param superView 一般指subView所在控制器的view
 */
- (void)viewManagerWithSuperView:(UIView *)superView;

/**
 *  设置subView的管理者为self
 *
 *  @param subView 管理的subView
 */
- (void)viewManagerWithSubView:(UIView *)subView;

/**
 *  设置添加subView的事件
 *
 *  @param subView 管理的subView
 *  @param info 附带信息，用于区分调用
 */
- (void)viewManagerWithHandleOfSubView:(UIView *)subView info:(NSString *)info;

/**
 *  得到其它viewManager所管理的subView，用于自己内部
 *
 *  @param viewInfo 其它的subViews
 */
- (void)viewManagerWithOtherSubViews:(NSDictionary *)viewInfo;

/**
 *  需要重新布局subView时，更改subView的frame或者约束
 *
 *  @param updateBlock 更新布局完成的block
 */
- (void)viewManagerWithLayoutSubViews:(void (^)( void))updateBlock;

/**
 *  使子视图更新到最新的布局约束或者frame
 */
- (void)viewManagerWithUpdateLayoutSubViews;

/**
 *  将model数据传递给viewManager
 */
- (void)viewManagerWithModel:(NSDictionary * (^) ( void))dictBlock;

/**
 *  处理viewBlock事件
 */
- (ViewEventBlock)viewManagerWithViewEventBlockOfInfo:(NSDictionary *)info;

/**
 *  处理ViewModelInfoBlock
 */
- (ViewModelInfoBlock)viewManagerWithViewModelBlockOfInfo:(NSDictionary *)info;

/**
 *  处理ViewManagerInfoBlock
 */
- (ViewManagerInfoBlock)viewManagerWithOtherViewManagerBlockOfInfo:(NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
