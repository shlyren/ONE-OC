//
//  ONEQuestionDetailViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEQuestionDetailViewController.h"
#import "ONEQuestionHeaderView.h"
#import "ONEQuestionItem.h"

@interface ONEQuestionDetailViewController ()
@property (nonatomic, weak) ONEQuestionHeaderView *questionHeaderView;
@end

@implementation ONEQuestionDetailViewController

- (ONEQuestionHeaderView *)questionHeaderView
{
    if ( _questionHeaderView == nil)
    {
        ONEWeakSelf
       __weak ONEQuestionHeaderView *questionHeaderView = [ONEQuestionHeaderView questionDetailHeaderView];
        questionHeaderView.contentChangeBlock = ^(CGFloat height){
            questionHeaderView.height = height;
            weakSelf.tableView.tableHeaderView = questionHeaderView;
        };

        _questionHeaderView =  questionHeaderView;
       
    }
    return _questionHeaderView;
}

- (NSString *)commentType
{
    return @"question";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.tableView.tableHeaderView = self.questionHeaderView;
    self.title = @"问答";
}

- (void)loadDetailData
{
    [super loadDetailData];
    ONEWeakSelf
    [SVProgressHUD show];
    [ONEDataRequest requestQuestionDetail:self.detail_id parameters:nil succsee:^(ONEQuestionItem *question) {
        if (question == nil) return;
        weakSelf.questionHeaderView.questionItem = question;
        [weakSelf.toolBarView setPraiseTitle:question.praisenum commentTitle:question.commentnum shareTitle:question.sharenum];
         weakSelf.toolBarView.typeStr = @"question";
        weakSelf.toolBarView.content_id = question.question_id;
//        weakSelf.toolBarView.praiseBtnClickBlock = ^(UIButton *praiseBtn){
//            return question.question_id;
//        };
        
        [weakSelf.tableView reloadData];
    } failure:nil];
}

- (void)loadRelatedData
{
    ONEWeakSelf
    [SVProgressHUD show];
    
    NSString *url = [related_question stringByAppendingPathComponent:self.detail_id];
    [ONEDataRequest requestQuestionRelated:url paramrters:nil success:^(NSArray *questionRelated) {
        if (!questionRelated.count) return;
        weakSelf.relatedItems = questionRelated;
        [super loadRelatedData];
    } failure:nil];
}

#pragma mark - table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.relatedItems.count)
    {
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCellID];
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
        ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:relatedCellID];
        cell.questionItem = self.relatedItems[indexPath.row];
        return cell.rowHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
