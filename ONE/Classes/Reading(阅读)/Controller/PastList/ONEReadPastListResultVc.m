//
//  ONEReadPastListResultVc.m
//  ONE
//
//  Created by 任玉祥 on 16/4/19.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEReadPastListResultVc.h"
#import "ONEDataRequest.h"
#import "ONEEssayItem.h"
#import "ONESerialItem.h"
#import "ONEQuestionItem.h"
#import "ONEReadRelatedCell.h"
#import "UITableView+Extension.h"


#import "ONEEssayDetailViewController.h"
#import "ONESerialDetailViewController.h"
#import "ONEQuestionDetailViewController.h"

@interface ONEReadPastListResultVc ()
@property (nonatomic, strong) NSArray *pastListResultArr;
@end

@implementation ONEReadPastListResultVc

static NSString *const pastListReusltCellId = @"pastListReusltCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.title = self.month;
    [self.tableView registerNib:[UINib nibWithNibName:@"ONEReadRelatedCell" bundle:nil] forCellReuseIdentifier:pastListReusltCellId];
    
}

/**
 *  通过block来做不同情况下的事情
 *
 *  @param myEssay    当是短篇时 执行这个block块里面的代码
 *  @param mySerial   当是连载时 执行这个block块里面的代码
 *  @param myQuestion 当是问答时 执行这个block块里面的代码
 */
- (void)actionWithEssay:(void(^)())myEssay serial:(void(^)())mySerial question:(void(^)())myQuestion
{
    if ([self.readPastListType isEqualToString:essay]) myEssay();
    if ([self.readPastListType isEqualToString:serialcontent]) mySerial();
    if ([self.readPastListType isEqualToString:question]) myQuestion();
}
/**
 *  数据请求
 */
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"/bymonth/%@", self.month];
    ONEWeakSelf
    [self actionWithEssay:^{  // 短篇
        [ONEDataRequest requestEssayRelated:[essay stringByAppendingString:url]
                                 paramrters:nil
                                    success:^(NSArray *  essayRelated) {
           if (essayRelated.count)
           {
               weakSelf.pastListResultArr = essayRelated;
               [weakSelf.tableView reloadData];
           }
       } failure:nil];
       
    } serial:^{ // 连载
       
       [ONEDataRequest requestSerialRelated:[serialcontent stringByAppendingString:url]
                                 paramrters:nil
                                    success:^(NSArray *serialRelated) {
            if (serialRelated.count)
            {
                weakSelf.pastListResultArr = serialRelated;
                [weakSelf.tableView reloadData];
            }
       } failure:nil];
       
    } question:^{ // 问答
       
        [ONEDataRequest requestQuestionRelated:[question stringByAppendingString:url]
                                    paramrters:nil
                                       success:^(NSArray *questionRelated) {
            if (questionRelated.count)
            {
                weakSelf.pastListResultArr = questionRelated;
                [weakSelf.tableView reloadData];
            }
        } failure:nil];
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowMessage:nil numberOfRows:self.pastListResultArr.count];
    return self.pastListResultArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView tableViewSetExtraCellLineHidden];
    ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:pastListReusltCellId];

    id item = self.pastListResultArr[indexPath.row];
    [self actionWithEssay:^{
        
        cell.essayItem = (ONEEssayItem *)item;
        
    } serial:^{
        
        cell.serialItem = (ONESerialItem *)item;
        
    } question:^{
        
        cell.questionItem = (ONEQuestionItem *)item;
        
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ONEReadRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:pastListReusltCellId];
    
    id item = self.pastListResultArr[indexPath.row];
    [self actionWithEssay:^{
        cell.essayItem = (ONEEssayItem *)item;
    } serial:^{
        cell.serialItem = (ONESerialItem *)item;
    } question:^{
        cell.questionItem = (ONEQuestionItem *)item;
    }];
    
    return cell.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    __block ONEReadDetailViewController *readDetailVc;
    
    [self actionWithEssay:^{
        
        readDetailVc = [ONEEssayDetailViewController new];
        ONEEssayItem *essayItem = self.pastListResultArr[indexPath.row];
        readDetailVc.detail_id = essayItem.content_id;
        
    } serial:^{
        
        readDetailVc = [ONESerialDetailViewController new];
        ONESerialItem *serialItem = self.pastListResultArr[indexPath.row];
        readDetailVc.detail_id = serialItem.content_id;
        
    } question:^{
        
        readDetailVc = [ONEQuestionDetailViewController new];
        ONEQuestionItem *questionItem = self.pastListResultArr[indexPath.row];
        readDetailVc.detail_id = questionItem.question_id;
        
    }];
    
    [self.navigationController pushViewController:readDetailVc animated:true];
}



@end
