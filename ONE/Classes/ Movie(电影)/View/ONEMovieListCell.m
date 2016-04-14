//
//  ONEMovieListCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieListCell.h"
#import "UIImageView+WebCache.h"
#import "ONEMovieListItem.h"

@interface ONEMovieListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;

@end

@implementation ONEMovieListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    return self;
    
}


- (void)setMovieListItem:(ONEMovieListItem *)movieListItem
{
    _movieListItem = movieListItem;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:movieListItem.cover] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"movieList_placeholder_%zd", arc4random_uniform(12)]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    }];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    
    [super setFrame:frame];
}

@end
