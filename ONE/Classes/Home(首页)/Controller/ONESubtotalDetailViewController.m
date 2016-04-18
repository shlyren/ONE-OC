//
//  ONESubtotalDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESubtotalDetailViewController.h"
#import "ONEHomeSubtotalItem.h"
#import "UIImageView+WebCache.h"
#import "NSMutableAttributedString+string.h"
#import "ONEDataRequest.h"

@interface ONESubtotalDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *hp_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hp_authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *hp_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hp_makettimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;


@end

@implementation ONESubtotalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = ONEColor(251, 244, 225, 1);
    self.title = self.subtotalItem.hp_title;
    
    /** 卡片基本属性设置 */
    self.cardView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.cardView.layer.borderWidth = 0.7f;
    self.cardView.layer.shouldRasterize = true;
    self.cardView.layer.rasterizationScale = UIScreen.mainScreen.scale;
    self.cardView.layer.cornerRadius = 7.0f;
    self.cardView.backgroundColor = ONEColor(245, 245, 245, 1);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.cardView addGestureRecognizer:pan];
    
    /** 设置数据 */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.subtotalItem.hp_img_url] placeholderImage:[UIImage imageNamed:@"123"]];
    self.hp_titleLabel.text = self.subtotalItem.hp_title;
    self.hp_authorLabel.text = self.subtotalItem.hp_author;
    self.hp_makettimeLabel.text = self.subtotalItem.hp_makettime;
    self.hp_contentLabel.attributedText = [NSMutableAttributedString attributedStringWithString:self.subtotalItem.hp_content];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", self.subtotalItem.praisenum] forState:UIControlStateNormal];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", self.subtotalItem.praisenum] forState:UIControlStateSelected];
}

/**
 *  拖动
 */
- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    CGPoint center = self.cardView.center;
    center.x += point.x;
    center.y += point.y;
    self.cardView.center = center;
    
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.175 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.cardView.center = self.view.center;
        }completion:nil];

    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (IBAction)shareBtnClick
{
    ONELogFunc
}

- (IBAction)praiseBtnClick
{
    if (!self.subtotalItem.hpcontent_id.length) return;
    
    NSDictionary *parameters = @{
                                 @"deviceid" : NSUUID.UUID.UUIDString,
                                 @"devicetype" : @"ios",
                                 @"itemid" : self.subtotalItem.hpcontent_id,
                                 @"type" : @"hpcontent"
                                 };
    
    [ONEDataRequest addPraise:praise_add parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        
        if (!isSuccess)
        {
            [SVProgressHUD showErrorWithStatus:message];
            
        }else{
            self.praiseBtn.selected = !self.praiseBtn.selected;
            NSInteger praisenum = self.praiseBtn.selected ? ++self.subtotalItem.praisenum : --self.subtotalItem.praisenum;
            [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
            [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateSelected];

        }
        
    } failure:nil];

}


@end
