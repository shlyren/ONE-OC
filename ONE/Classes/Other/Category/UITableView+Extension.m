//
//  UITableView+Extension.m
//  tableView扩展
//
//  Created by 任玉祥 on 16/3/9.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

/**
 *  通过tableViewDataSource来判断当没有数据时,去掉tableviewCell的分割线，并在tableview上显示一些信息
 *
 *  @param message 显示的内容
 *  @param count   row的个数
 */
- (void)tableViewShowMessage:(NSString *)message numberOfRows:(NSInteger)rowCount;
{
    if (!rowCount)
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UILabel *backLabel = [[UILabel alloc] init];
        backLabel.text = message;
        backLabel.textColor = [UIColor blackColor];
        backLabel.textAlignment = NSTextAlignmentCenter;
        [backLabel sizeToFit];
        
        self.backgroundView = backLabel;
        
    }else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
}

/**
 *  隐藏tableViewCell多余的分割线
 */
- (void)tableViewSetExtraCellLineHidden
{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self setTableFooterView:view];
    
}

/**
 *  tableView headerView 的文字
 *
 *  @param title 文字
 *
 *  @return label
 */
- (UILabel *)tableViewHeaderViewLabelWithString:(NSString *)title
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:12];
    [titleLabel sizeToFit];
    titleLabel.centerY = 35 * 0.5;
    titleLabel.x = 15;
    
    return titleLabel;
}



@end
