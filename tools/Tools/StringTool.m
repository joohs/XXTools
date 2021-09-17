//
//  StringTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "StringTool.h"

@implementation StringTool

// 判断字符串为空
+ (BOOL)isEmpty:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

// 检查字符串是否是纯数字
+ (BOOL)checkStringIsOnlyDigital:(NSString *)str {
    NSString *string = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

//检查字符串是否为nil 转为@""
+ (NSString *)string:(NSString *)str {
    if ([self isEmpty:str]) {
        return @"";
    } else {
        return str;
    }
}

/**
 将含有汉字的URLString转码
 */
+ (NSString *)urlStringEncoded:(NSString *)urlString {
    return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

//判断字符串中包含汉字
+ (BOOL)checkStringIsContainerChineseCharacter:(NSString *)string {
    for (int i = 0; i < string.length; i++) {
        int a = [string characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//汉字转为带有音标的字符串
+ (NSString *)hanziPhonogramTransform:(NSString *)hanzi {
    if ([hanzi length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanzi];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            return ms;
        }
    }
    return nil;
}

//汉字转为不带音标的字符串
+ (NSString *)hanziTransform:(NSString *)hanzi {
    if ([hanzi length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanzi];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                return ms;
            }
        }
    }
    return nil;
}

//过滤特殊字符串
+ (NSString *)filterSpecialString:(NSString *)string {
    NSCharacterSet *dontWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+,.;':|/@!? "];
    //stringByTrimmingCharactersInSet只能去掉首尾的特殊字符串
    return [[[string componentsSeparatedByCharactersInSet:dontWant] componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

//计算字符串尺寸
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size {
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
}

//复制
+ (void)copy:(NSString *)string {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = string;
}

#pragma mark - 获取某个子字符串在某个总字符串中位置数组
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText {
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [text rangeOfString:findText];
    if (rang.location != NSNotFound && rang.length !=0) {
        [arrayRanges addObject:@{@"location":[NSNumber numberWithInteger:rang.location],
                                 @"length":[NSNumber  numberWithInteger:findText.length]}];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int ii = 0;; ii++)
        {
            if (0 == ii) {
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }
            else
            {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:@{@"location":[NSNumber numberWithInteger:rang1.location],
                                         @"length":[NSNumber  numberWithInteger:findText.length]}];
        }
        return arrayRanges;
    }
    return nil;
}

@end
