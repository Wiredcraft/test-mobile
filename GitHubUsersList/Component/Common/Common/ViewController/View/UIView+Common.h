//
//  UIView+Common.h
//  YUIAll
//
//  Created by YUI on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Common)

@property (nonatomic, assign) UIEdgeInsets subviewEdge;
@property (nonatomic, assign) NSInteger subviewSpacingWidth;
@property (nonatomic, assign) NSInteger subviewSpacingHeight;

@property (nonatomic, assign) NSInteger style;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger internalIndex;

- (void)setupLayoutParams;

@end

NS_ASSUME_NONNULL_END
