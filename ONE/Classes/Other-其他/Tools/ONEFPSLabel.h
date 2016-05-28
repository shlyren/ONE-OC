//
//  ONEFPSLabel.h
//  ONE
//
//  Created by 任玉祥 on 16/4/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONEFPSLabel : UILabel


+ (instancetype)shareInstance;

+ (void)setupFPSLabel;

+ (void)showFPSLabel;

+ (void)hiddenFPSLabel;

@end
