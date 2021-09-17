//
//  EncryptTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptTool : NSObject

/**
 md5加密
 */
+ (NSString *)md5Encrypt:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
