//
//  ONEBaseSettingViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/20.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEBaseSettingViewController.h"

@implementation ONEBaseSettingViewController

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

- (NSMutableArray *)settingItems
{
    if (!_settingItems) {
        _settingItems = [NSMutableArray array];
    }
    return _settingItems;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:self.tableViewStyle];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ONEDefaultCellItem *cellItem = self.settingItems[indexPath.section].items[indexPath.row];
    cell.accessoryType = cellItem.accessoryType;
    cell.accessoryView = cellItem.accessoryView;
    cell.textLabel.text = cellItem.title;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ONEDefaultCellItem *cellItem = self.settingItems[indexPath.section].items[indexPath.row];
    if (cellItem.actionBlock) {
        cellItem.actionBlock(indexPath);
    }
    
    if ([cellItem isKindOfClass:[ONEDefaultCellArrItem class]])
    {
        ONEDefaultCellArrItem *arrItem = (ONEDefaultCellArrItem *)cellItem;
        [self.navigationController pushViewController:[arrItem.pushClass new] animated:true];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.settingItems[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.settingItems[section].footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.settingItems[section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.settingItems[section].footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.settingItems[section].headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.settingItems[section].footerHeight;
}

@end
