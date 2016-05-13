//
//  ONEMovieListCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieListCell.h"
#import "UIImageView+WebCache.h"
#import "ONEMovieListItem.h"
#import "ONEMovieScoreView.h"

@interface ONEMovieListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (nonatomic, weak) ONEMovieScoreView *movieScoreView;
@end

@implementation ONEMovieListCell

- (ONEMovieScoreView *)movieScoreView
{
    if (_movieScoreView == nil) {
        ONEMovieScoreView *movieScoreView = [[ONEMovieScoreView alloc] initWithFrame:CGRectMake(self.width - 90, self.height - 50, 90, 50)];
        
        [self.contentView addSubview:_movieScoreView = movieScoreView];
    }
    
    return _movieScoreView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
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
    
    [self.movieScoreView setScoreTitle:movieListItem.score];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

@end
