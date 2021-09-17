//
//  DateTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateTool : NSObject

/**
 获取当前时间戳ms
 */
+ (NSString *)getCurrentTimestamp;

/**
 获取当天时间Format yyyy-MM-dd
 */
+ (NSString *)getCurrentDateFormat;

/**
 获取当天时间Format yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentDateCompleteFormat;

/**
 时间format yyyy-MM-dd
 */
+ (NSString *)dateFormat:(NSDate *)date;

/**
 和今天相差几天
 */
+ (NSInteger)differenceDays:(NSString *)endDay;

@end

NS_ASSUME_NONNULL_END
