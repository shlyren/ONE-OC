//
//  ONEPersionHeaderView.h
//  ONE
//
//  Created by JiaQi on 2016/12/9.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEAuthorItem.h"
@interface ONEPersionHeaderView : UIView
@property (nonatomic, strong) ONEAuthorItem *author;

+ (instancetype)persionHeaderViewFrame:(CGRect)frame;
@end
