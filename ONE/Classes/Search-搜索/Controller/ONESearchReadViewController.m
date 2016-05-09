//
//  ONESearchReadViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchReadViewController.h"
#import "ONESearchReadItem.h"
#import "ONEEssayDetailViewController.h"
#import "ONESerialDetailViewController.h"
#import "ONEQuestionDetailViewController.h"


@implementation ONESearchReadViewController

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeRead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    ONESearchReadItem *item = self.searchResult[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.type];
    cell.textLabel.text = item.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ONESearchReadItem *item = self.searchResult[indexPath.row];
    
    ONEReadDetailViewController *readVc = nil;
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
