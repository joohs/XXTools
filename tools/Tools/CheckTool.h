//
//  CheckTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckTool : NSObject

/**
 检查是否为正确手机号码
 */
+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber;

/**
 检查邮箱地址格式
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress;

/**
 判断身份证是否合法
 */
+ (BOOL)checkIdentityNumber:(NSString *)number;

/**
 从身份证里面获取性别 男 或者 女 不正确的身份证返回nil
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number;

/**
 从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
