//
//  ONEMoviePastListVc.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMoviePastListVc.h"
#import "ONEMoreSubtotalViewController.h"

@implementation ONEMoviePastListVc


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ONEMoreSubtotalViewController *subtotalVc = [ONEMoreSubtotalViewController new];
    subtotalVc.title = subtotalVc.month = self.pastLists[indexPath.row];
    [self.navigationController pushViewController:subtotalVc animated:true];
    
}

@end
