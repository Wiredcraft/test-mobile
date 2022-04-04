//
//  YUIModelProtocol.h
//  YUIAll
//
//  Created by YUI on 2021/5/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YUIModelProtocol <NSObject>

@optional

+ (instancetype)sharedInstance;

/**
 对象转换
 creating instances from a configuration object

 @param object  任意类对象
 @return 类对象
 */
+ (instancetype)instanceWithModel:(id)object;

- (instancetype)initWithModel:(id)object;

/**
 循环对象转换

 @param objectArray 任意类对象数组
 @return 对象数组
 */
+ (NSArray *)instanceWithModelArray:(NSArray *)objectArray;


/**
 实例化字典转换
 
 @param dictionary 字典
 @return 类对象
 */
+ (instancetype)instanceWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 循环实例化字典转换
 
 @param dictionaryArray 字典数组
 @return 对象数组
 */
+ (NSArray *)instanceWithDictionaryArray:(NSArray *)dictionaryArray;



//+ (NSDictionary *)JSONKeyPathsByPropertyKey;
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper;

+ (NSDictionary *)modelContainerPropertyGenericClass;

+ (instancetype)instanceWithJSONDictionary:(NSDictionary *)dictionary;

//- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary;

/**
 循环实例化字典转换
 
 @param dictionaryArray 字典数组
 @return 对象数组
 */
+ (NSArray *)instanceWithJSONDictionaryArray:(NSArray *)dictionaryArray;



/**
字典转换
 
 @return 对象数组
 */
- (NSDictionary *)dictionaryWithModel;

- (NSDictionary *)jSONDictionaryWithModel;
/**
 循环字典转换

 @param objectArray 对象数组
 @return 字典数组
 */
+ (NSArray<NSDictionary *> *)dictionaryWithModelArray:(NSArray<NSObject *> *)objectArray;

+ (NSArray<NSDictionary *> *)jSONDictionaryWithModelArray:(NSArray<NSObject *> *)objectArray;

////creating an instance using NSCoding
///**
//实例化NSCoding转换
//
// @param decoder 对象NSCoder
// @return 类对象
// */
//+ (instancetype)instanceWithCoder:(NSCoder *)decoder;
//- (instancetype)initWithCoder:(NSCoder *)decoder;

- (NSArray *)getAllProperties;

/// 通过属性名匹配并赋值数据
/// @param object 输入匹配对象
- (void)setDataWithMatchModelProperty:(NSObject *)object;



- (void)didInitialize;

- (void)setDataWithObject:(id<NSObject>)object;

- (void)setDataWithDictionary:(NSDictionary *)dictionary;


/// 数据处理
- (void)processData;

/**
 重置 初始化数据
 */
- (void)restoreData;

/**
 释放 对应释放部分初始化数据
 */
- (void)releaseData;

@end

NS_ASSUME_NONNULL_END
