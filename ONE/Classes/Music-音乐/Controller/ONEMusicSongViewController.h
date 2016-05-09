//
//  ONEMusicSongViewController.h
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONEMusicSongViewController : UITableViewController
/** 用户的id 获取用户的歌单  */
@property (nonatomic, strong) NSString *user_id;

/** 月份 格式:yyyy-MM  获取往期的歌单 */
@property (nonatomic, strong) NSString *month;

@end
