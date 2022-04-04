//
//  YUIModelFrame.h
//  YUIAll
//
//  Created by YUI on 2021/4/22.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YUIModelFrame : NSObject

@property (nonatomic, strong) id<NSObject> model;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) NSMutableArray <NSValue *>* subviewFrames;

@end

NS_ASSUME_NONNULL_END
