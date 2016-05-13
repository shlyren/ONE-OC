//
//  ONEMovieScoreView.m
//  ONE
//
//  Created by 任玉祥 on 16/5/2.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMovieScoreView.h"

@interface ONEMovieScoreView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ONEMovieScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        ONEMovieScoreView *scoreView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
        scoreView.frame = frame;
        scoreView.x -= ONEDefaultMargin;
        scoreView.y -= 50;
        scoreView.transform = CGAffineTransformMakeRotation(-M_PI_4 * 0.2);
        self = scoreView;
    }
    
    return self;
}

- (void)setScoreTitle:(NSString *)scoreNum
{
    self.scoreLabel.text = scoreNum;
}


@end
