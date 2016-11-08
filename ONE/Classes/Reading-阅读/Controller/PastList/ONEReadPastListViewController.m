//
//  ONEReadPastListViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/19.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadPastListViewController.h"
#import "ONEReadPastListResultVc.h"

@implementation ONEReadPastListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ONEReadPastListResultVc *pastListResultVC = [ONEReadPastListResultVc new];
    pastListResultVC.readPastListType = self.readPastListType;
    pastListResultVC.month = self.pastLists[indexPath.row];
    [self.navigationController pushViewController:pastListResultVC animated:true];
    
}

@end
