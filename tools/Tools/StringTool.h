//
//  StringTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringTool : NSObject

/**
  判断字符串为空
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 检查字符串是否是纯数字
 */
+ (BOOL)checkStringIsOnlyDigital:(NSString *)str;

/**
 处理字符串，将空转为""
 */
+ (NSString *)string:(NSString *)str;

/**
 将含有汉字的URLString转码
 */
+ (NSString *)urlStringEncoded:(NSString *)urlString;

/**
 判断字符串中包含汉字
 */
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string;

/**
 过滤特殊字符串
 */
+ (NSString *)filterSpecialString:(NSString *)string;

/**
 计算字符串尺寸
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

/**
 汉字转为带有音标的字符串
 */
+ (NSString *)hanziPhonogramTransform:(NSString *)hanzi;

/**
 汉字转为不带音标的字符串
 */
+ (NSString *)hanziTransform:(NSString *)hanzi;

/**
 复制内容到面板
 */
+ (void)copy:(NSString *)string;

/**
 获取某个子字符串在某个总字符串中位置数组
 */
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;

@end

NS_ASSUME_NONNULL_END
