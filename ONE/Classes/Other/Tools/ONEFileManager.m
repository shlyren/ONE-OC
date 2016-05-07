//
//  ONEFileManager.m
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEFileManager.h"

@implementation ONEFileManager
#define cachesPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

+ (BOOL)removeDirectoryAtCaches
{
    return [self removeDirectoryAtPath:cachesPath];
}

+ (BOOL)removeDirectoryAtPath:(NSString *)directoryPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 报错:抛异常
        [[NSException exceptionWithName:@"filePathError" reason:@"传错,必须传文件夹路径" userInfo:nil] raise];
    }

    NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
  
    NSError *error = nil;
    
    for (NSString *subPath in subpaths) {
        
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        // 不知为什么真机上Snapshots文件夹下的文件删不掉
        if ([filePath containsString:@"Snapshots"]) continue;
    
        if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
            ONELog(@"缓存删除失败%@", error);
            return false;
        }
    }
    return true;
}

+ (NSString *)getDirectorySizeByMBAtCaches
{
    NSInteger totalSize = [self getDirectorySizeAtPath:cachesPath];
    // MB
    if (totalSize > 1000 * 1000) return [NSString stringWithFormat:@"清除缓存(%.1fMB)",totalSize / 1000.0 / 1000.0];
    // KB
    if (totalSize > 1000) return [NSString stringWithFormat:@"清除缓存(%.1fKB)",totalSize / 1000.0];
    // B
    return [NSString stringWithFormat:@"清除缓存(%ldB)",totalSize];

}

// 获取文件夹尺寸
+ (NSInteger)getDirectorySizeAtPath:(NSString *)directoryPath
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 报错:抛异常
        [[NSException exceptionWithName:@"filePathError" reason:@"笨蛋,传错,必须传文件夹路径" userInfo:nil] raise];
    }
    
    /*
     获取这个文件夹中所有文件路径,然后累加 = 文件夹的尺寸
     */
   
    // 获取文件夹下所有的文件
    NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0;
    
    for (NSString *subpath in subpaths) {
        
        // 拼接文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
        
        // 排除文件夹
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 隐藏文件
        if ([filePath containsString:@".DS"]) continue;
       
        // 过滤 Snapshots 文件夹
        if ([filePath containsString:@"Snapshots"]) continue;
       
        // 指定路径获取这个路径的属性
        // attributesOfItemAtPath:只能获取文件属性
        NSInteger size = [[mgr attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += size;
    }
    
    return totalSize;
}

@end
