//
//  CheckTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "CheckTool.h"

@implementation CheckTool

/**
 *  检查是否为正确手机号码
 */

+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  检查邮箱地址格式
 */
+ (BOOL)checkEmailAddress:(NSString *)EmailAddress {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString = EmailAddress.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}

/**
 *  判断身份证是否合法
 */
+ (BOOL)checkIdentityNumber:(NSString *)number {
    //必须满足以下规则
    //1. 长度必须是18位或者15位，前17位必须是数字，第十八位可以是数字或X
    //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
    //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
    //4. 第17位表示性别，双数表示女，单数表示男
    //5. 第18位为前17位的校验位
    //算法如下：
    //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
    //（2）余数 ＝ 校验和 % 11
    //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
    //6. 出生年份的前两位必须是19或20
    number = [number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //1⃣️判断位数
    if (number.length != 15 && number.length != 18) {
        return NO;
    }
    //2⃣️将15位身份证转为18位
    NSMutableString *mString = [NSMutableString stringWithString:number];
    if (number.length == 15) {
        //出生日期加上年的开头
        [mString insertString:@"19" atIndex:6];
        //最后一位加上校验码
        [mString insertString:[self getLastIdentifyNumberForIdentifyNumber:mString] atIndex:[mString length]];
        number = mString;
    }
    //3⃣️开始判断
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    //区域
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![regexTest evaluateWithObject:number]) {
        return NO;
    }
    //4⃣️验证校验码
    return [[self getLastIdentifyNumberForIdentifyNumber:number] isEqualToString:[number substringWithRange:NSMakeRange(17, 1)]];
}

/**
 *  从身份证里面获取性别男或者女不正确的身份证返回nil
 */
+ (NSString *)getGenderFromIdentityNumber:(NSString *)number {
    if ([self checkIdentityNumber:number]) {
        NSInteger i = [[number substringWithRange:NSMakeRange(number.length - 2, 1)] integerValue];
        if (i % 2 == 1) {
            return @"男";
        } else {
            return @"女";
        }
    } else {
        return nil;
    }
}
/**
 *  从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 */
+ (NSString *)getBirthdayFromIdentityNumber:(NSString *)number {
    if ([self checkIdentityNumber:number]) {
        if (number.length == 18) {
            return [NSString stringWithFormat:@"%@年%@月%@日",[number substringWithRange:NSMakeRange(6,4)], [number substringWithRange:NSMakeRange(10,2)], [number substringWithRange:NSMakeRange(12,2)]];
        }
        if (number.length == 15) {
            return [NSString stringWithFormat:@"19%@年%@月%@日",[number substringWithRange:NSMakeRange(6,2)], [number substringWithRange:NSMakeRange(8,2)], [number substringWithRange:NSMakeRange(10,2)]];
        };
        return nil;
    } else {
        return nil;
    }
}

+ (NSString *)getLastIdentifyNumberForIdentifyNumber:(NSString *)number {
    //位数不小于17
    if (number.length < 17) {
        return nil;
    }
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    long p =0;
    for (int i =0; i<=16; i++){
        NSString * s = [number substringWithRange:NSMakeRange(i, 1)];
        p += [s intValue]*R[i];
    }
    //校验位
    int o = p%11;
    NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
    return string_content;
}

@end
