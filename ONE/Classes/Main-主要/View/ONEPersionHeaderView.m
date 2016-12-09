//
//  ONEPersionHeaderView.m
//  ONE
//
//  Created by JiaQi on 2016/12/9.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEPersionHeaderView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"
#import "UIViewController+Extension.m"

#pragma mark - 获取当前view的控制
@implementation UIView (ZYExtend)
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController *)nextResponder;
    }
    return nil;
}
@end

@interface ONEPersionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *xiaojiBtn;
@property (weak, nonatomic) IBOutlet UIButton *gedanBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ONEPersionHeaderView
+ (instancetype)persionHeaderViewFrame:(CGRect)frame;
{
    ONEPersionHeaderView *Header = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    Header.frame = frame;
    return Header;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setAuthor:(ONEAuthorItem *)author
{
    _author = author;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:author.web_url] placeholderImage:[UIImage imageNamed:@"personal"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImgV.image = [image circleImage];
    }];

    self.nameLabel.text = author.user_name;
    self.scoreLabel.text = author.score;
    
}
- (IBAction)dismiss
{
    [self.window.rootViewController dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)jiaojiBtnCLick
{
    [self pushVcTitle:@"ta的小记"];
}
- (IBAction)gedanBtnClick
{
    [self pushVcTitle:@"ta的歌单"];
}


- (void)pushVcTitle:(NSString *)title
{
    UIViewController *vc = [UIViewController new];
    vc.title = title;
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = nil;
    if ([self.viewController isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)self.viewController;
    }else {
        nav = self.viewController.navigationController;
    }
    [nav pushViewController:vc animated:true];
}
@end
