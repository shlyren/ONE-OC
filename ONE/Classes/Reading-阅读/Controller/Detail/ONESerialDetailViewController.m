//
//  ONESerialDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/14.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESerialDetailViewController.h"
#import "ONESerialItem.h"

@interface ONESerialDetailViewController ()

@end

@implementation ONESerialDetailViewController
- (NSString *)commentType
{
    return @"serial";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"连载";
}

- (void)loadDetailData
{
    [super loadDetailData];
    ONEWeakSelf
    
    [ONEDataRequest requestSerialDetail:self.detail_id parameters:nil succsee:^(ONESerialItem *serial) {
        if (!serial) return ;
        weakSelf.headerView.serialItem = serial;
        [weakSelf.toolBarView setPraiseTitle:serial.praisenum commentTitle:serial.commentnum shareTitle:serial.sharenum];
        weakSelf.toolBarView.shareButtonClickBlock = ^(UIButton *btn){
            NSString *content = [NSString stringWithFormat:@"《%@》\n%@",serial.title, serial.excerpt];
            [ONEShareTool showShareView:self
                                content:content
                                    url:serial.web_url
                                  image:[UIImage imageNamed:@"shareicon"]];
        };
        weakSelf.toolBarView.typeStr = @"serial";
        weakSelf.toolBarView.content_id = serial.content_id;
        [weakSelf.tableView reloadData];
    } failure:nil];
}


- (void)loadRelatedData
{
    
    
    NSString *url =  [related_serial stringByAppendingPathComponent:self.detail_id];
    [ONEDataRequest requestSerialRelated:url paramrters:nil success:^(NSArray *serialRelated) {
        if (!serialRelated.count) return;
        self.relatedItems = serialRelated;
        [super loadRelatedData];
    } failure:nil];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCellID];
        cell.serialItem = self.relatedItems[indexPath.row];
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONESerialItem *item = self.relatedItems[indexPath.row];
        ONESerialDetailViewController *detailVc = [ONESerialDetailViewController new];
        detailVc.detail_id = item.content_id;
        [self.navigationController pushViewController:detailVc animated:true];
    }
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCellID];
        cell.serialItem = self.relatedItems[indexPath.row];
        return cell.rowHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
@end
