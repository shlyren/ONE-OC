//
//  ONESettingViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/5/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESettingViewController.h"
#import "ONEDefaultCellGroupItem.h"
#import "ONELoginViewController.h"
#import "ONEFileManager.h"
#import "SVProgressHUD.h"
@interface ONESettingViewController ()
@property (nonatomic, strong) NSMutableArray<ONEDefaultCellGroupItem *> *settingItems;
@end

@implementation ONESettingViewController

- (NSMutableArray *)settingItems
{
    if (!_settingItems) {
        _settingItems = [NSMutableArray array];
    }
    
    return _settingItems;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        self = [super initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupGroups];
}


- (void)setupGroups
{
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup1
{
    ONEDefaultCellArrItem *item1 = [ONEDefaultCellArrItem itemWithTitle:@"登录" image:nil pushClass:[ONELoginViewController class]];
    item1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ONEDefaultCellGroupItem *group1 = [ONEDefaultCellGroupItem groupWithItems:@[item1]];
    [self.settingItems addObject:group1];
}
- (void)setupGroup2
{
    ONEDefaultCellItem *item1 = [ONEDefaultCellItem itemWithTitle:@"缓存到本地"];
    UISwitch *s = [UISwitch new];
    BOOL isON = [[NSUserDefaults standardUserDefaults] boolForKey: ONEAutomaticCacheKey];
    [s setOn:isON animated:true];
    [s addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    item1.accessoryView = s;

    NSString *item2Title = [ONEFileManager getDirectorySizeByMBAtCaches];
    ONEDefaultCellItem *item2 = [ONEDefaultCellItem itemWithTitle:item2Title action:^(NSIndexPath *indexPath) {
        if ([ONEFileManager removeDirectoryAtCaches]) {
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
        }else {
            [SVProgressHUD showErrorWithStatus:@"清除失败"];
        }
        ONEDefaultCellItem *item = self.settingItems[indexPath.section].items[indexPath.row];
        item.title = [ONEFileManager getDirectorySizeByMBAtCaches];
        [self.tableView reloadData];
    }];
    
    item2.accessoryType = UITableViewCellAccessoryNone;
    ONEDefaultCellGroupItem *group2 = [ONEDefaultCellGroupItem groupWithItems:@[item1, item2]];
    [self.settingItems addObject:group2];
}

- (void)switchChanged:(UISwitch *)s
{
    [[NSUserDefaults standardUserDefaults] setBool:s.isOn forKey: ONEAutomaticCacheKey];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.settingItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems[section].items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ONEDefaultCellItem *cellItem = self.settingItems[indexPath.section].items[indexPath.row];
    cell.accessoryType = cellItem.accessoryType;
    cell.accessoryView = cellItem.accessoryView;
    cell.textLabel.text = cellItem.title;
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
     ONEDefaultCellItem *cellItem = self.settingItems[indexPath.section].items[indexPath.row];
    
    if ([cellItem isKindOfClass:[ONEDefaultCellArrItem class]]) {
        ONEDefaultCellArrItem *arrItem = (ONEDefaultCellArrItem *)cellItem;
        [self.navigationController pushViewController:[arrItem.pushClass new] animated:true];
    }
    if (cellItem.actionBlock) {
        cellItem.actionBlock(indexPath);
    }
}
@end
