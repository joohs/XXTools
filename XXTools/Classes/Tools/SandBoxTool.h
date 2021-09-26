//
//  SandBoxTool.h
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SandBoxTool : NSObject

/**
 获取文档路径
 */
+ (NSString *)pathDocuments;

/**
 获取缓存文件路径
 */
+ (NSString *)pathCaches;

/**
 获取文件在文档中的路径
 */
+ (NSString *)pathDocumentsWithFileName:(NSString *)name;

/**
 获取文件在缓存文件的路径
 */
+ (NSString *)pathCachesWithFileName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
