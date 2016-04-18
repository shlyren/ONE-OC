//
//  ONEQuestionDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEQuestionDetailViewController.h"
#import "ONEQuestionHeaderView.h"
#import "ONEQuestionItem.h"

@interface ONEQuestionDetailViewController ()<ONEReadDetailHeaderViewDelegate>
@property (nonatomic, weak) ONEQuestionHeaderView *questionHeaderView;
@end

@implementation ONEQuestionDetailViewController

- (ONEQuestionHeaderView *)questionHeaderView
{
    if ( _questionHeaderView == nil)
    {
        ONEQuestionHeaderView *questionHeaderView = [ONEQuestionHeaderView questionDetailHeaderView];
        questionHeaderView.height = 300;
        questionHeaderView.delegate = self;
        _questionHeaderView =  questionHeaderView;
        self.tableView.tableHeaderView = questionHeaderView;
    }
    return _questionHeaderView;
}

//- (NSString *)commentUrl
//{
//    return commnet_question;
//}

- (NSString *)commentType
{
    return @"question";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"问答";
}

- (void)loadDetailData
{
    [super loadDetailData];
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestQuestionDetail:self.detail_id parameters:nil succsee:^(ONEQuestionItem *question) {
        [SVProgressHUD dismiss];
        if (question == nil) return;
        weakSelf.questionHeaderView.questionItem = question;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loadRelatedData
{
    ONEWeakSelf
    [ONEDataRequest requestQuestionRelated:self.detail_id paramrters:nil success:^(NSArray *questionRelated) {
        if (!questionRelated.count) return;
        weakSelf.relatedItems = questionRelated;
        [super loadRelatedData];
    } failure:nil];
}

#pragma mark ONEReadDetailHeaderViewDelegate
- (void)readDetailHeaderView:(ONEReadDetailHeaderView *)detailHeaderView didChangedHeight:(CGFloat)height
{
    self.questionHeaderView.height = height;
    self.tableView.tableHeaderView = self.questionHeaderView;
}

#pragma mark - table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCell];
        cell.questionItem = self.relatedItems[indexPath.row];
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count) {
        ONEQuestionDetailViewController *questionVc = [ONEQuestionDetailViewController new];
        ONEQuestionItem *item = self.relatedItems[indexPath.row];
        questionVc.detail_id = item.question_id;
        [self.navigationController pushViewController:questionVc animated:true];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCell];
        cell.questionItem = self.relatedItems[indexPath.row];
        return cell.rowHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
