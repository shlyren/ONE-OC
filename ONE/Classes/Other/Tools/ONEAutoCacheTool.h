//
//  ONEAutoCacheTool.h
//  ONE
//
//  Created by 任玉祥 on 16/5/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEAutoCacheTool : NSObject
+ (void)writeFile:(NSDictionary *)file withUrl:(NSString *)url;
+ (NSDictionary *)readFileAtPath:(NSString *)path;
@end
