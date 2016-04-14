//
//  ONECommentCell.h
//  ONE
//
//  Created by 任玉祥 on 16/4/2.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ONEMusicCommentItem;
@class ONECommentCell;

@protocol ONECommentCellDelegate <NSObject>

- (void)commentCell:(ONECommentCell *)commentCell didClickIcon:(NSString *)userId;

@end

@interface ONECommentCell : UITableViewCell

@property (nonatomic, strong) ONEMusicCommentItem   *commentItem;

@property (nonatomic, strong) NSString              *detail_id;

@property (nonatomic, assign) CGFloat               rowHeight;


@property (nonatomic, weak) id<ONECommentCellDelegate> delegate;


@end
