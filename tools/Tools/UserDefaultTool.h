//
//  UserDefaultTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultTool : NSObject

#pragma mark - UserDefault的保存，获取，删除key

+ (void)remove:(NSString *)key;

+ (Boolean)getBool:(NSString *)key;

+ (void)setBool:(Boolean)value key:(NSString *)key;

+ (NSInteger)getInteger:(NSString *)key;

+ (void)setInteger:(NSInteger)value key:(NSString *)key;

+ (double)getDouble:(NSString *)key;

+ (void)setDouble:(double)value key:(NSString *)key;

+ (NSString *)getString:(NSString *)key;

+ (void)setString:(NSString *)value key:(NSString *)key;

+ (NSArray *)getArray:(NSString *)key;

+ (void)setArray:(NSArray *)value key:(NSString *)key;

+ (id)getObject:(NSString *)key;

+ (void)setObject:(id)value key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
