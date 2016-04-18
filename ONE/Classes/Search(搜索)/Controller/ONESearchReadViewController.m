//
//  ONESearchReadViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESearchReadViewController.h"
#import "ONESearchReadItem.h"
#import "ONEEssayDetailViewController.h"
#import "ONESerialDetailViewController.h"
#import "ONEQuestionDetailViewController.h"
#import "ONEReadDetailViewController.h"

@interface ONESearchReadViewController ()

@end

@implementation ONESearchReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setSearchKey:(NSString *)searchKey
{
    if ([self.searchKey isEqualToString:searchKey]) return;
    [super setSearchKey:searchKey];
    ONEWeakSelf
    [SVProgressHUD showWithStatus:@"搜索中..."];
    [ONEDataRequest requestSearchRead:self.searchKey success:^(NSArray *readResult) {
        if (readResult.count) {
            weakSelf.searchResult = readResult;
            [weakSelf.tableView reloadData];
        }
        
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView cellForRowAtIndexPath:indexPath];
    static NSString *readCell = @"readCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:readCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:readCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    
    ONESearchReadItem *item = self.searchResult[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.type];
    cell.textLabel.text = item.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONESearchReadItem *item = self.searchResult[indexPath.row];
    
    ONEReadDetailViewController *readVc;
    if ([item.type isEqualToString:@"essay"]) {
        readVc = [ONEEssayDetailViewController new];
    }
    if ([item.type isEqualToString:@"serialcontent"]) {
        readVc = [ONESerialDetailViewController new];
    }
    if ([item.type isEqualToString:@"question"]) {
        readVc = [ONEQuestionDetailViewController new];
    }
    
    readVc.detail_id = item.read_id;
    
    [self.navigationController pushViewController:readVc animated:true];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
