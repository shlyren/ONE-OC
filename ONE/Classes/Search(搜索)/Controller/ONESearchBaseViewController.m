//
//  ONESearchBaseViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONESearchBaseViewController.h"
#import "UITableView+Extension.h"

@interface ONESearchBaseViewController ()

@end

@implementation ONESearchBaseViewController
static NSString *const searchTableViewCell = @"searchTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ONESearchTableViewCell" bundle:nil] forCellReuseIdentifier:searchTableViewCell];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowMessage:nil numberOfRows:self.searchResult.count];
    [tableView tableViewShowImage:@"search_null_image" numberOfRows:self.searchResult.count];
    return self.searchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView tableViewSetExtraCellLineHidden];
    ONESearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchTableViewCell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
