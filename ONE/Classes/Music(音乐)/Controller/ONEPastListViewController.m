//
//  ONEPastListViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/10.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEPastListViewController.h"
#import "UITableView+Extension.h"
#import "ONEMusicSongViewController.h"


@interface ONEPastListViewController ()
@property (nonatomic, strong) NSArray *pastLists;
@end

@implementation ONEPastListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"往期列表";
    _pastLists = @[@"本月", @"2016-03", @"2016-02", @"2016-01"];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pastLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *pastLiseCellId = @"pastList";
    [tableView tableViewSetExtraCellLineHidden];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pastLiseCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pastLiseCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.pastLists[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    ONEMusicSongViewController *songVc = [ONEMusicSongViewController new];
    
    if (indexPath.row == 0) {
        songVc.month = @"2016-04";
    }else{
        songVc.month = self.pastLists[indexPath.row];
    }
    songVc.title = self.pastLists[indexPath.row];
    [self.navigationController pushViewController:songVc animated:true];
    
}
@end
