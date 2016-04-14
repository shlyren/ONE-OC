//
//  ONEEssayDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEEssayDetailViewController.h"

@interface ONEEssayDetailViewController ()

@end

@implementation ONEEssayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadDetailData
{
    [ONEDataRequest requestEssayDetail:self.detail_id parameters:nil succsee:^(ONEEssayItem *essay) {
        
        if (essay) {
            self.headerView.essayItem = essay;
        }
        
    } failure:^(NSError *error) {
        
    }];
}


@end
