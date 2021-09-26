//
//  TransformTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransformTool : NSObject

/**
 *  json字符串转字典
 */
+ (NSDictionary *)transformToDictionary:(NSString *)str;

/**
 *  json字符串转数组
 */
+ (NSArray *)transformToArray:(NSString *)str;

/**
 *  data转字典
 */
+ (NSDictionary *)transformDataToDictionary:(NSData *)data;

/**
 *  data转数组
 */
+ (NSDictionary *)transformDataToArray:(NSData *)data;

/**
 *  data转字符串
 */
+ (NSDictionary *)transformDataToString:(NSData *)data;

/**
 将array或者diction转为json字符串
 */
+ (NSString *)transformToString:(id)object;

@end

NS_ASSUME_NONNULL_END
