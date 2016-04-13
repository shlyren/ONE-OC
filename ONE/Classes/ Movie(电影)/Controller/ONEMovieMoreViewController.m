//
//  ONEMovieMoreViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/13.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEMovieMoreViewController.h"

@interface ONEMovieMoreViewController ()

@end

@implementation ONEMovieMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)loadData{}
- (void)loadMoreData{}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end


