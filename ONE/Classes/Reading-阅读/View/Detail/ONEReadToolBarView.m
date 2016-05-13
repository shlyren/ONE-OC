//
//  ONEReadToolBarView.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadToolBarView.h"
#import "ONEDataRequest.h"
#import "ONELoginViewController.h"
#import "ONENavigationController.h"

@interface ONEReadToolBarView ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation ONEReadToolBarView

+ (instancetype)toolBarView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setPraiseTitle:(NSString *)praiseTitle commentTitle:(NSString *)commentTitle shareTitle:(NSString *)shareTitle
{
    [self.praiseBtn setTitle:praiseTitle forState:UIControlStateNormal];
    [self.praiseBtn setTitle:praiseTitle forState:UIControlStateSelected];
    
    [self.commentBtn setTitle:commentTitle forState:UIControlStateNormal];
    [self.commentBtn setTitle:commentTitle forState:UIControlStateHighlighted];
    
    [self.shareBtn setTitle:shareTitle forState:UIControlStateNormal];
    [self.shareBtn setTitle:shareTitle forState:UIControlStateHighlighted];
}

- (IBAction)praiseBtnClick
{
    
    if (!self.content_id.length)return;
    if (!self.typeStr.length) return;
    NSDictionary *parameters =  @{
                                  @"deviceid"    : NSUUID.UUID.UUIDString,
                                  @"devicetype"  : @"ios",
                                  @"itemid"      : self.content_id,
                                  @"type"        : self.typeStr
                                  };
    [ONEDataRequest addPraise:praise_add parameters:parameters success:^(BOOL isSuccess, NSString *message) {
        
        if (!isSuccess)
        {
            [SVProgressHUD showErrorWithStatus:message];
        }else{
            
            NSInteger praisenum = [self.praiseBtn titleForState:UIControlStateNormal].integerValue;
            praisenum = self.praiseBtn.selected ? --praisenum : ++praisenum;
            [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateNormal];
            [self.praiseBtn setTitle:[NSString stringWithFormat:@"%zd", praisenum] forState:UIControlStateSelected];
             self.praiseBtn.selected = !self.praiseBtn.selected;
        }
        
    } failure:nil];
    
}

- (IBAction)commentBtnClick
{

    ONENavigationController *nav = [[ONENavigationController alloc] initWithRootViewController:[ONELoginViewController new]];
    nav.delegate = self;
    [self.window.rootViewController presentViewController:nav animated:true completion:nil];
}

- (IBAction)shareBtnClick:(UIButton *)btn
{
    if (self.shareButtonClickBlock) {
        self.shareButtonClickBlock(btn);
    }
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
     [navigationController setNavigationBarHidden:[viewController isKindOfClass:ONELoginViewController.class] animated:true];
}

@end
