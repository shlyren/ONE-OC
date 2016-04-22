//
//  ONEMoreSubtotalLayout.m
//  ONE
//
//  Created by 任玉祥 on 16/4/17.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEMoreSubtotalLayout.h"

@interface ONEMoreSubtotalLayout ()

// 总列数
#define columnCount 2

/** 这个字典用来存储每一列最大的Y值(每一列的高度) */
@property (nonatomic, strong) NSMutableDictionary *maxYDict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;


@end

@implementation ONEMoreSubtotalLayout
- (NSMutableDictionary *)maxYDict
{
    if (_maxYDict == nil) {
        self.maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil)
    {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


- (void)prepareLayout
{
    self.sectionInset = UIEdgeInsetsMake(0, 5, 10, 5);
    
    // 1.清空最大的Y值
    for (NSInteger i = 0; i < columnCount; i++)
    {
        NSString *column = [NSString stringWithFormat:@"%zd", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    // 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if (maxY.floatValue < [self.maxYDict[minColumn] floatValue]) minColumn = column;
    }];
    
    // 计算尺寸
    CGFloat width = (self.collectionView.width - self.sectionInset.left - self.sectionInset.right - (columnCount - 1) * ONEDefaultMargin) / columnCount;
    CGFloat height = 0.0;
    
    if (self.delegate == nil)
    {
         [[NSException exceptionWithName:@"ONEMoreSubtotalLayout delegate is nil" reason:@"Must implemented ONEMoreSubtotalLayoutDelegate method 'subtotallowLayout:heightForWidth:atIndexPath:'" userInfo:nil] raise];
    }
    
    if ([self.delegate respondsToSelector:@selector(subtotallowLayout:heightForWidth:atIndexPath:)])
    {
        height = [self.delegate subtotallowLayout:self heightForWidth:width atIndexPath:indexPath];
    }else{
        ///Users/Schnappi/Documents/Git/oneIsAll/ONE/Classes/Home(首页)/Controller/ONEMoreSubtotalViewController.m:21:17: Method 'subtotallowLayout:heightForWidth:atIndexPath:' in protocol 'ONEMoreSubtotalLayoutDelegate' not implemented
        
        [[NSException exceptionWithName:@"ONEMoreSubtotalLayoutDelegate method not implemented" reason:@"Must implemented ONEMoreSubtotalLayoutDelegate method 'subtotallowLayout:heightForWidth:atIndexPath:'" userInfo:nil] raise];
    }
    
    // 计算位置
    CGFloat x = self.sectionInset.left + (width + ONEDefaultMargin) * minColumn.intValue;
    CGFloat y = [self.maxYDict[minColumn] floatValue] + ONEDefaultMargin;
    
    // 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
    
}

@end
