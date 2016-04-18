//
//  ONESearchMusicItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONEAuthorItem.h"

@interface ONESearchMusicItem : NSObject

@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) ONEAuthorItem *author;
@property (nonatomic, strong) NSString *music_id;
/** id */
@property (nonatomic, strong) NSString *music_detail_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *platform;

@end
