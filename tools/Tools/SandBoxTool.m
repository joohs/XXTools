//
//  SandBoxTool.m
//  plasticScan
//
//  Created by Jon on 2021/6/21.
//

#import "SandBoxTool.h"

@implementation SandBoxTool

//获取文档路径
+ (NSString *)pathDocuments {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

//获取缓存文件路径
+ (NSString *)pathCaches {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

//获取文件在文档中的路径
+ (NSString *)pathDocumentsWithFileName:(NSString *)name {
    return [[self pathDocuments] stringByAppendingString:name];
}

//获取文件在缓存文件的路径
+ (NSString *)pathCachesWithFileName:(NSString *)name {
    return [[self pathCaches] stringByAppendingString:name];
}

@end
