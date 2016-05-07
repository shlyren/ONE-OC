//
//  ONEAutoCacheTool.m
//  ONE
//
//  Created by 任玉祥 on 16/5/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEAutoCacheTool.h"
#define cachesPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
@implementation ONEAutoCacheTool

+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@/", cachesPath, path];
    
    BOOL isDirectory = false;
    BOOL isExist = [manager fileExistsAtPath:fullPath isDirectory:&isDirectory];
    
    if (isExist && isDirectory) return true;
    
    NSError * error = nil;
    BOOL success = [manager createDirectoryAtPath:fullPath withIntermediateDirectories:true attributes:nil error:&error];
    if (success) {
        ONELog(@"创建成功 %@", path);
        return true;
    }else {
        ONELog(@"文件夹创建失败%@", error);
        return false;
    }
    
}

#define filePath [NSString stringWithFormat:@"%@/%@/caches.ren", cachesPath, path]


+ (void)writeFile:(id)file withUrl:(NSString *)url
{
    if (![file isKindOfClass:[NSDictionary class]]) return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dict = (NSDictionary *)file;
        NSString  *path = [self stringByReplacingUrlOfBundleID:url];
        
        if ([self createDirectoryAtPath:path]) {
            
            NSString *fullPath = filePath;
            
            BOOL flag = [NSKeyedArchiver archiveRootObject:dict toFile:fullPath];
            if (flag) {
                ONELog(@"缓存成功 %@/caches.ren", path)
            }else {
                ONELog(@"%@", [NSThread currentThread])
            }
        }
    });
}

+ (void)readFileAtPath:(NSString *)path completion:(void (^)(NSDictionary *))completion
{
    path = [self stringByReplacingUrlOfBundleID:path];
//    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    ONELog(@"%@/%@",cachesPath,path)
    ONELog(@"使用缓存 %@/caches.ren", path);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(dict);
        });
    });

}


+ (NSString *)stringByReplacingUrlOfBundleID:(NSString *)httpUrl
{
    NSString *str = [NSString stringWithFormat:@"%@/", [[NSBundle mainBundle] bundleIdentifier]];
    return [httpUrl stringByReplacingOccurrencesOfString:@"http://v3.wufazhuce.com:8000/" withString:str];
}
@end
