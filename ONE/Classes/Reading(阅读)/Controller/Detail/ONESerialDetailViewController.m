//
//  ONESerialDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESerialDetailViewController.h"

@interface ONESerialDetailViewController ()

@end

@implementation ONESerialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)loadDetailData
{
    [ONEDataRequest requestSerialDetail:self.detail_id parameters:nil succsee:^(ONESerialItem *serial) {
        if (!serial) return ;
        self.headerView.serialItem = serial;
    } failure:^(NSError *error) {
        
    }];
}
@end
