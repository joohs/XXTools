//
//  TransformTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "TransformTool.h"

@implementation TransformTool

/**
 *  json字符串转字典
 */
+ (NSDictionary *)transformToDictionary:(NSString *)str {
    NSError *error;
    if (str == nil) {
        return @{};
    }
    id object = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        NSLog(@"transformToDictionary fail。%@", error);
        return nil;
    }
    return (NSDictionary *)object;
}

/**
 *  data转字典
 */
+ (NSDictionary *)transformDataToDictionary:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        NSLog(@"transformToDictionary fail。%@", error);
        return nil;
    }
    return (NSDictionary *)object;
}

/**
 *  data转数组
 */
+ (NSDictionary *)transformDataToArray:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        NSLog(@"transformToDictionary fail。%@", error);
        return nil;
    }
    return (NSDictionary *)object;
}

/**
 *  data转字符串
 */
+ (NSDictionary *)transformDataToString:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        NSLog(@"transformToDictionary fail。%@", error);
        return nil;
    }
    return (NSDictionary *)object;
}

/**
 *  json字符串转数组
 */
+ (NSArray *)transformToArray:(NSString *)str {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        NSLog(@"transformToArray fail。%@", error);
        return nil;
    }
    return (NSArray *)object;
}

/**
 将array或者diction转为json字符串
 */
+ (NSString *)transformToString:(id)object {
    if (![object isKindOfClass:[NSArray class]] && ![object isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (error != nil) {
        NSLog(@"transformToString fail。%@", error);
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
