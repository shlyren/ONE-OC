//
//  ONEPastListViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/10.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEPastListViewController.h"
#import "UITableView+Extension.h"
#import "ONEMusicSongViewController.h"

@implementation ONEPastListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"往期列表";
    _pastLists = [self arryWithEndDate:self.endMonth];
}

- (NSArray *)arryWithEndDate:(NSString *)endDateStr;
{
    
    if (endDateStr.length < 6) return nil;
    
    NSString *enDash = @"";
    
    if (endDateStr.length > 6)
    {
       enDash = [endDateStr substringWithRange:NSMakeRange(4, endDateStr.length - 6)];
    }
    
    /** 时间格式 */
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy%@MM", enDash];
    NSDateFormatter *yearFor = [NSDateFormatter new];
    yearFor.dateFormat = [NSString stringWithFormat:@"yyyy"];
    NSDateFormatter *monthFor = [NSDateFormatter new];
    monthFor.dateFormat = [NSString stringWithFormat:@"MM"];
    
    /** 截止的时间 */
    NSDate *endDate = [formatter dateFromString:endDateStr];
    if (endDate == nil) return nil;
    NSInteger endYear = [[yearFor stringFromDate:endDate] integerValue];;
    NSInteger endMonth = [[monthFor stringFromDate:endDate] integerValue];
    
    /** 当前的时间 */
    NSDate *currentDate = [NSDate date];
    NSInteger currentYear = [[yearFor stringFromDate:currentDate] integerValue];
    NSInteger currentMonth = [[monthFor stringFromDate:currentDate] integerValue];;
    
    NSInteger maxMonth = 0;
    NSInteger minMonth = 0;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSInteger resYear = currentYear; resYear >= endYear; resYear--)
    {
        maxMonth = resYear == currentYear ? currentMonth : 12;
        minMonth = resYear == endYear ? endMonth : 1;
        
        for (NSInteger resMonth = maxMonth; resMonth >= minMonth; resMonth--)
        {
            [tmpArr addObject:[NSString stringWithFormat:@"%zd%@%02zd",resYear, enDash,resMonth]];
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
    
    cell.textLabel.text = indexPath.row ? self.pastLists[indexPath.row] : @"本月";
    
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
