//
//  ONESearchReadItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONESearchReadItem : NSObject
@property (nonatomic, assign) NSInteger number;
/** id */
@property (nonatomic, strong) NSString *read_id; //
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@end
