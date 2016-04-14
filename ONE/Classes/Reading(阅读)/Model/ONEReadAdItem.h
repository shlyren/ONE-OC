//
//  ONEReadAdItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEReadAdItem : NSObject

/** id */
@property (nonatomic, strong) NSString *ad_id;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *cover;

@property (nonatomic, strong) NSString *bottom_text;

@property (nonatomic, strong) NSString *bgcolor;

@property (nonatomic, strong) NSString *pv_url;
@end
