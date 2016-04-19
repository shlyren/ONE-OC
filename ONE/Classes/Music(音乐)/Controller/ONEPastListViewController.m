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

@implementation ONEPastListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"往期列表";
    _pastLists = [self arryWithEndDateStr:self.endMonth];
}

- (NSArray *)arryWithEndDateStr:(NSString *)endDateStr
{
    if (![endDateStr containsString:@"-"]) return nil;
    
    /** 当前的时间 */
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM";
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSInteger currentYear = currentDate.integerValue;
    NSRange range = [currentDate rangeOfString:@"-"];
    if (range.location != NSNotFound)
    {
        currentDate = [currentDate stringByReplacingCharactersInRange:NSMakeRange(0, range.location + range.length) withString:@""];
    }
    NSInteger currentMonth = currentDate.integerValue;
    
    
    /** 截止的时间 */
    NSInteger endYear = endDateStr.integerValue;
    range = [endDateStr rangeOfString:@"-"];
    if (range.location != NSNotFound)
    {
        endDateStr = [endDateStr stringByReplacingCharactersInRange:NSMakeRange(0, range.location + range.length) withString:@""];
    }
    NSInteger endMonth = endDateStr.integerValue;
    
    NSInteger maxMonth = 0;
    NSInteger minMonth = 0;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSInteger resYear = currentYear; resYear >= endYear; resYear--)
    {
        maxMonth = resYear == currentYear ? currentMonth : 12;
        minMonth = resYear == endYear ? endMonth : 1;
        
        for (NSInteger resMonth = maxMonth; resMonth >= minMonth; resMonth--)
        {
            [tmpArr addObject:[NSString stringWithFormat:@"%zd-%02zd",resYear, resMonth]];
        }
    }
    
    return tmpArr;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pastLists.count;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView tableViewSetExtraCellLineHidden];
    
    static NSString *pastLiseCellId = @"pastList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pastLiseCellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pastLiseCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"本月";
    }else{
     cell.textLabel.text = self.pastLists[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    ONEMusicSongViewController *songVc = [ONEMusicSongViewController new];
    songVc.month = self.pastLists[indexPath.row];
    songVc.title = self.pastLists[indexPath.row];
    
    [self.navigationController pushViewController:songVc animated:true];
    
}
@end
