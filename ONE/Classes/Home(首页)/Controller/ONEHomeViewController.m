//
//  ONEHomeViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEHomeViewController.h"
#import "YSLDraggableCardContainer.h"
#import "ONEDraggableCardView.h"
#import "ONEDataRequest.h"
#import "ONEHomeSubtotalItem.h"
#import "ONEMoviePastListVc.h"

@interface ONEHomeViewController ()<YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource>

@property (nonatomic, weak) YSLDraggableCardContainer *cardContainer;
@property (nonatomic, strong) NSArray *homeSubtotals;

@property (weak, nonatomic) IBOutlet UIButton *praiseButton;

@end

@implementation ONEHomeViewController

- (YSLDraggableCardContainer *)cardContainer
{
    if (_cardContainer == nil)
    {
        YSLDraggableCardContainer *cardContainer = [[YSLDraggableCardContainer alloc]init];
        cardContainer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        cardContainer.backgroundColor = [UIColor clearColor];
        cardContainer.dataSource = self;
        cardContainer.delegate = self;
        cardContainer.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
        [self.view insertSubview:_cardContainer = cardContainer atIndex:0];

    }
    return _cardContainer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    [SVProgressHUD show];
    ONEWeakSelf
    [ONEDataRequest requestHomeSubtotal:@"more/0" paramrters:nil success:^(NSArray *homeSubtotal) {
        [SVProgressHUD dismiss];
        if (homeSubtotal.count)
        {
            weakSelf.homeSubtotals = homeSubtotal;
            [weakSelf.cardContainer reloadCardContainer];
        }
    } failure:nil];
}

#pragma mark - YSLDraggableCardContainerDataSource
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return self.homeSubtotals.count;
}

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    ONEDraggableCardView *cardView = [[ONEDraggableCardView alloc]initWithFrame:CGRectMake(10, ONENavBMaxY + ONEDefaultMargin, ONEScreenWidth - 20, ONEScreenWidth * 1.1)];
    cardView.subbtotaItem = self.homeSubtotals[index];
    
    return cardView;
}

#pragma mark - YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:false];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:false];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:false];
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已经显示完毕" message:@"您还可以?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再看一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [container reloadCardContainer];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看往期作品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [container reloadCardContainer];
        });
        
        ONEMoviePastListVc *pastListVc = [ONEMoviePastListVc new];
        pastListVc.endMonth = @"2012-10";
        [self.navigationController pushViewController:pastListVc animated:true];
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:true completion:nil];

}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didShowDraggableViewAtIndex:(NSInteger)index
{
    ONEHomeSubtotalItem *item = self.homeSubtotals[index];
    [self.praiseButton setTitle:item.praisenum forState:UIControlStateNormal];
    [self.praiseButton setTitle:item.praisenum forState:UIControlStateSelected];
}

#pragma mark - Events
- (IBAction)shareBtnClick
{
    ONEMoviePastListVc *pastListVc = [ONEMoviePastListVc new];
    pastListVc.endMonth = @"2012-10";
    [self.navigationController pushViewController:pastListVc animated:true];
}

- (IBAction)praiseBtnClick
{
    self.praiseButton.selected = !self.praiseButton.selected;
}
@end
