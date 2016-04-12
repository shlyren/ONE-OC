//
//  ONEMovieDetailPhotoCell.m
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieDetailPhotoCell.h"
#import "UIImageView+WebCache.h"


@interface ONEMovieDetailPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ONEMovieDetailPhotoCell

- (void)setPhotoName:(NSString *)photoName
{
    _photoName = photoName;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoName] placeholderImage:[UIImage imageNamed:@"center_image_collection"]];
}

@end
