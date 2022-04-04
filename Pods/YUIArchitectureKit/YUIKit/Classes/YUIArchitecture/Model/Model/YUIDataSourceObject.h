//
//  YUIDataSourceObject.h
//  YUIAll
//
//  Created by YUI on 2021/7/15.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "YUIModelManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YUIDataSourceObject : NSObject <UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, weak) id<YUIModelManagerProtocol> modelManager;

@end

NS_ASSUME_NONNULL_END
