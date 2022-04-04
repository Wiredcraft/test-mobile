//
//  CommonEmptyDataTableSetViewDelegateObject.h
//  YUIAll
//
//  Created by YUI on 2021/6/10.
//

#import <Foundation/Foundation.h>

#import <UIScrollView+EmptyDataSet.h>

#import <YUIArchitecture.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonEmptyDataSetSourceAndDelegateObject : NSObject <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *imageURLStr;

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) YUIModelManager *modelManager;

- (void)didInitialize;

@end

NS_ASSUME_NONNULL_END
