//
//  CommonManager.h
//  YUIAll
//
//  Created by YUI on 2018/12/18.
//  Copyright © 2018年 YUI. All rights reserved.
//

#import "YUIModelManager.h"

//#import "ModelAndJSONAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommonManagerDelegate <NSObject>

@optional

- (void)startLodingAnimation;

- (void)endLodingAnimation;

- (void)showRequestPromptView:(NSString *)prompt;

@end

@interface CommonModelManager : YUIModelManager

@property (nonatomic, weak) id<CommonManagerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
