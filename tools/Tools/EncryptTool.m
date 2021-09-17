//
//  EncryptTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "EncryptTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptTool

//md5加密
+ (NSString *)md5Encrypt:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

@end
