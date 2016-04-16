//
//  ONECommentCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONEMusicCommentItem;

@interface ONECommentCell : UITableViewCell

@property (nonatomic, strong) ONEMusicCommentItem   *commentItem;

@property (nonatomic, strong) NSString              *detail_id;

@property (nonatomic, assign) CGFloat               rowHeight;



/**
 *  是属于哪一种评论的点赞参数 比如 阅读,还是音乐
 *
 *  @return 对应类型的的参数 比如音乐 "music"
 */
- (NSString *)commentType;

@end
