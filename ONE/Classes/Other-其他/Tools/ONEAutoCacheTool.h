//
//  ONEAutoCacheTool.h
//  ONE
//
//  Created by 任玉祥 on 16/5/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEAutoCacheTool : NSObject
/**
 *  写入数据到本地磁盘
 *
 *  @param file 文件
 *  @param url  文件的url地址
 */
+ (void)writeFile:(NSDictionary *)file withUrl:(NSString *)url;

/**
 *  加载本地缓存
 *
 *  @param path       文件路径
 *  @param completion 加载成功的回调
 */
+ (void)readFileAtPath:(NSString *)path completion:(void (^)(NSDictionary *))completion;
@end
