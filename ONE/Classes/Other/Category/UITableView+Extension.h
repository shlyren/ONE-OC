//
//  UITableView+Extension.h
//  tableView扩展
//
//  Created by 任玉祥 on 16/3/9.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)

/**
 *  通过tableViewDataSource来判断当没有数据时,去掉tableviewCell的分割线，并在tableview上显示一些信息
 *
 *  @param message 显示的内容
 *  @param count   row的个数
 */
- (void)tableViewShowMessage:(NSString *)message numberOfRows:(NSInteger)rowCount;

/**
 *  隐藏tableViewCell多余的分割线
 *  cellForRowAtIndexPath 方法中调用
 */
- (void)tableViewSetExtraCellLineHidden;

/**
 *  tableView headerView 的文字
 *
 *  @param title 文字
 *
 *  @return label
 */
- (UILabel *)tableViewHeaderViewLabelWithString:(NSString *)title;


/**
 *  tableView footerView 的文字
 *
 *  @param title 文字
 *
 *  @return label
 */
- (UILabel *)tableViewFooterViewLabelWithString:(NSString *)title;
@end
