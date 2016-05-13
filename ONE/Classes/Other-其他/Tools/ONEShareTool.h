//
//  ONEShareTool.h
//  ONE
//
//  Created by 任玉祥 on 16/5/12.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ONEShareTool : NSObject

/**
 *  初始化分享工具
 */
+ (void)setupShareTool;

/**
 *  弹出一个分享列表的类似iOS6的UIActivityViewController控件
 *
 *  @param controller 在该controller弹出分享列表的UIActionSheet
 *  @param content    分享编辑页面的内嵌文字
 *  @param url        分享的url
 *  @param image      分享内嵌图片
 */
+ (void)showShareView:(UIViewController *)controller
              content:(NSString *)content
                  url:(NSString *)url
                image:(UIImage *)image;

/**
 *  添加系统回调
 *
 */
+ (BOOL)handleOpenURL:(NSURL *)url;
@end
