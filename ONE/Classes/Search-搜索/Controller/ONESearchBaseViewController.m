//
//  ONESearchBaseViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONESearchBaseViewController.h"
#import "UITableView+Extension.h"
#import "ONEDataRequest.h"

@interface ONESearchBaseViewController ()

@property (nonatomic, strong) NSArray *searchResult;
@end

@implementation ONESearchBaseViewController
static NSString *const searchTableViewCell = @"searchTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"ONESearchTableViewCell" bundle:nil] forCellReuseIdentifier:searchTableViewCell];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(30, 0, 0, 0);
}

- (ONESearchContentType)searchContentType
{
    return ONESearchContentTypeNone;
}

- (NSArray *)searchResult
{
    return _searchResult;
}

- (void)setSearchKey:(NSString *)searchKey
{
    if ([self.searchKey isEqualToString:searchKey]) return;
    _searchKey = searchKey;
    
    ONEWeakSelf
    [SVProgressHUD showWithStatus:@"搜索中..."];
    
    void (^successBlock)(NSArray *result) = ^(NSArray *result) {
        if (result.count) {
            weakSelf.searchResult = result;
            [weakSelf.tableView reloadData];
        }
    };
    
    switch (self.searchContentType)
    {
        case ONESearchContentTypeHp:
        {
            [ONEDataRequest requestSearchHp:searchKey success:^(NSArray *hpResult) {
                successBlock(hpResult);
            } failure:nil];
            break;
        }
            
        case ONESearchContentTypeRead:
        {
            [ONEDataRequest requestSearchRead:self.searchKey success:^(NSArray *readResult) {
                successBlock(readResult);
            } failure:nil];
            break;
        }
            
        case ONESearchContentTypeMusic:
        {
            
            [ONEDataRequest requestSearchMusic:searchKey success:^(NSArray *musicResult) {
                successBlock(musicResult);
            } failure:nil];
            break;
        }
            
        case ONESearchContentTypeMovie:
        {
            [ONEDataRequest requestSearchMovie:self.searchKey success:^(NSArray *movieResult) {
                successBlock(movieResult);
            } failure:nil];

            break;
        }
            
        case ONESearchContentTypeAuthor:
        {
            [ONEDataRequest requestSearchAuthor:self.searchKey success:^(NSArray *authorResult) {
                successBlock(authorResult);
            } failure:nil];
            
            break;
        }
        default: break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowImage:@"search_null_image" numberOfRows:self.searchResult.count];
    return self.searchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView tableViewSetExtraCellLineHidden];

    if (self.searchContentType == ONESearchContentTypeHp ||
        self.searchContentType == ONESearchContentTypeMusic)
    {
        return [tableView dequeueReusableCellWithIdentifier:searchTableViewCell];
    }

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(0, ONEDefaultMargin, 0, 0);
    }

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
