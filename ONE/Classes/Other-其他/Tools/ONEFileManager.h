//
//  ONEFileManager.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//  专门用于处理文件业务

#import <Foundation/Foundation.h>

@interface ONEFileManager : NSObject

/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getDirectorySizeAtPath:(NSString *)directoryPath;

/**
 *  获取Caches文件夹下的文件大小
 *
 *  @return @"清除缓存(XXX)"
 */
+ (NSString *)getDirectorySizeByMBAtCaches;

/**
 *  删除文件夹下所有文件
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)removeDirectoryAtPath:(NSString *)directoryPath;


/**
 *  删除Caches文件夹下所有文件
 *
 *  @return 是否删除成功
 */
+ (BOOL)removeDirectoryAtCaches;
@end
