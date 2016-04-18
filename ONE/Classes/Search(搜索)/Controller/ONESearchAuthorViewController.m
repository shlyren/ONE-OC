//
//  ONESearchAuthorViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESearchAuthorViewController.h"
#import "ONEAuthorItem.h"
#import "ONEPersonDetailViewController.h"

@interface ONESearchAuthorViewController ()

@end

@implementation ONESearchAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)setSearchKey:(NSString *)searchKey
{
    
    if ([self.searchKey isEqualToString:searchKey]) return;
    [super setSearchKey:searchKey];
     ONEWeakSelf
     [SVProgressHUD show];
    [ONEDataRequest requestSearchAuthor:self.searchKey success:^(NSArray *authorResult) {
         [SVProgressHUD dismiss];
        if (authorResult.count) {
            self.searchResult = authorResult;
            [weakSelf.tableView reloadData];
        }
        
    } failure:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    static NSString *authorCell = @"authorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:authorCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:authorCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ONEAuthorItem *item = self.searchResult[indexPath.row];
    cell.textLabel.text = item.user_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONEPersonDetailViewController *persionVc = [ONEPersonDetailViewController new];
    ONEAuthorItem *item = self.searchResult[indexPath.row];
    persionVc.user_id = item.user_id;
    [self.navigationController pushViewController:persionVc animated:true];
}

@end
