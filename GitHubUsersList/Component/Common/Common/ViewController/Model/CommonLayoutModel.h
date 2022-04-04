//
//  CommonModel.h
//  YUIAll
//
//  Created by YUI on 2018/12/18.
//  Copyright © 2018年 YUI. All rights reserved.
//

#import "YUIModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonLayoutModel : YUIModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *chartletURLStr;
@property (nonatomic, copy) NSString *iconURLStr;

@end

NS_ASSUME_NONNULL_END
