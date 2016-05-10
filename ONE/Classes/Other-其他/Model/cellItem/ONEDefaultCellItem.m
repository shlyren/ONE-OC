//
//  ONEDefaultCellItem.m
//  ONE
//
//  Created by 任玉祥 on 16/4/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEDefaultCellItem.h"

@implementation ONEDefaultCellItem

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle
                    cellStyle:(UITableViewCellStyle)cellStyle
                accessoryType:(UITableViewCellAccessoryType)accessoryType
                accessoryView:(UIView *)accessoryView
                       action:(ONECellActionBlock)actionBlock
{
    ONEDefaultCellItem *item = [self new];
    item.title = title;
    item.image = image;
    item.subTitle = subTitle;
    item.cellStyle = cellStyle;
    item.accessoryType = accessoryType;
    item.accessoryView = accessoryView;
    item.actionBlock = actionBlock;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title
                         image:nil
                      subTitle:nil
                     cellStyle:UITableViewCellStyleDefault
                 accessoryType:UITableViewCellAccessoryNone
                 accessoryView:nil
                        action:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
{
    return [self itemWithTitle:title
                         image:image
                      subTitle:nil
                     cellStyle:UITableViewCellStyleDefault
                 accessoryType:UITableViewCellAccessoryNone
                 accessoryView:nil
                        action:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title
                       action:(ONECellActionBlock)actionBlock
{
    return [self itemWithTitle:title
                         image:nil
                      subTitle:nil
                     cellStyle:UITableViewCellStyleDefault
                 accessoryType:UITableViewCellAccessoryNone
                 accessoryView:nil
                        action:actionBlock];
}

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle
{
    return [self itemWithTitle:title
                         image:image
                      subTitle:subTitle
                     cellStyle:UITableViewCellStyleDefault
                 accessoryType:UITableViewCellAccessoryNone
                 accessoryView:nil
                        action:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                     subTitle:(NSString *)subTitle
                       action:(ONECellActionBlock)actionBlock
{
    return [self itemWithTitle:title
                         image:image
                      subTitle:subTitle
                     cellStyle:UITableViewCellStyleDefault
                 accessoryType:UITableViewCellAccessoryNone
                 accessoryView:nil
                        action:actionBlock];
}
@end
