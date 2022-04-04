//
//  YUIModelManagerSubclassingHooksProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIModelManagerProtocol <NSObject>

@optional

#pragma mark -- init

- (void)didInitialize;

#pragma mark -- data

///  从本地或服务器加载数据Model
- (void)loadData:(nullable id)parameter;

///  赋值至ModelManagar,作为通用接口
- (void)setData:(id)parameter;

///  从本类取值，作为通用接口
- (nullable id)getData:(id)parameter;

///  Model上传至服务器
- (void)uploadData:(nullable id)parameter;

///  从服务器下载数据
- (void)downloadData:(nullable id)parameter;

///  Model保存数据至服务器或本地
- (void)saveData:(nullable id)parameter;

///  处理数据
- (void)processData:(nullable id)parameter;

///  刷新数据
- (void)refreshData:(nullable id)parameter;

///  重置数据
- (void)restoreData:(nullable id)parameter;

///  释放数据
- (void)releaseData:(nullable id)parameter;

@end

NS_ASSUME_NONNULL_END
