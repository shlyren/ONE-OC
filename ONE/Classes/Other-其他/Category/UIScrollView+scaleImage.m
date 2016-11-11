//
//  UIScrollView+scaleImage.m
//  ONE
//
//  Created by 任玉祥 on 2016/7/29.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "UIScrollView+scaleImage.h"
#import <objc/runtime.h>
#import "UIScrollView+MJExtension.h"

/** 交换方法的分类 */
@interface NSObject (exchangeMethod)

/** 交换类方法 */
+ (void)yx_exchangeClassMethodWithoOrigSelector:(SEL)origSelector
                                swizzleSelector:(SEL)swizzleSelector;

/** 交换对象方法 */
+ (void)yx_exchangeInstanceMethodWithoOrigSelector:(SEL)origSelector
                                   swizzleSelector:(SEL)swizzleSelector;

@end

@implementation NSObject (exchangeMethod)

+ (void)yx_exchangeClassMethodWithoOrigSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    Method origMethod = class_getClassMethod(self, origSelector);
    Method swizzleMethod = class_getClassMethod(self, swizzleSelector);
    // 注意：不能直接交换方法实现，需要判断原有方法是否存在,存在才能交换
    // 如何判断？添加原有方法，如果成功，表示原有方法不存在，失败，表示原有方法存在
    // 原有方法可能没有实现，所以这里添加方法实现，用自己方法实现
    // 这样做的好处：方法不存在，直接把自己方法的实现作为原有方法的实现，调用原有方法，就会来到当前方法的实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

+ (void)yx_exchangeInstanceMethodWithoOrigSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

@end


@implementation UIScrollView (scaleImage)

#define KeyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))

static char *const imageViewKey = "imageViewKey";
static char *const imageViewHeight = "imageViewHeight";
static char *const isInitialKey = "isInitialKey";

static CGFloat const imageHeight = 200;

#pragma mark - exchangeMethod
+ (void)load
{
    [self yx_exchangeInstanceMethodWithoOrigSelector:@selector(setTableHeaderView:)
                                     swizzleSelector:@selector(setYx_tableHeaderView:)];
}

- (void)setYx_tableHeaderView:(UIView *)yx_tableHeaderView
{
    
    [self setYx_tableHeaderView:yx_tableHeaderView];
    UITableView *tableView = (UITableView *)self;
    self.yx_height = tableView.tableHeaderView.frame.size.height;
}

#pragma mark - lazy load
- (UIImageView *)headerImageView
{
    UIImageView *imageView = objc_getAssociatedObject(self, imageViewKey);
    
    if (!imageView)
    {
        imageView = [UIImageView new];
        imageView.clipsToBounds = true;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self insertSubview:imageView atIndex:0];
        
        
        objc_setAssociatedObject(self, imageViewKey, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageView;

}

#pragma mark - property
- (void)setYx_image:(UIImage *)yx_image
{
    [self headerImageView].image = yx_image;
    [self setupHeaderImageView];
}

- (UIImage *)yx_image
{
    return [self headerImageView].image;
}

- (void)setYx_height:(CGFloat)yx_height
{
    objc_setAssociatedObject(self, imageViewHeight, @(yx_height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self setupHeaderImageViewFrame];
    
}

- (CGFloat)yx_height
{
    CGFloat height = [objc_getAssociatedObject(self, imageViewHeight) floatValue];
    return height ? : imageHeight;
}

#pragma mark - other
- (BOOL)isInitial
{
    return [objc_getAssociatedObject(self, isInitialKey) boolValue];
}

- (void)setIsInitial:(BOOL)isInitial
{
    objc_setAssociatedObject(self, isInitialKey, @(isInitial), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupHeaderImageViewFrame
{
    [self headerImageView].frame = CGRectMake(0, 0, self.bounds.size.width, self.yx_height);
    self.x = CGRectGetMaxY([self headerImageView].frame);
}

- (void)setupHeaderImageView
{
    [self setupHeaderImageViewFrame];
    if (![self isInitial])
    {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self setIsInitial:true];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offSetY = self.contentOffset.y;
    if (offSetY < 0) {
        [self headerImageView].frame = CGRectMake(offSetY, offSetY, self.bounds.size.width - offSetY * 2, self.yx_height - offSetY);
    } else{
        [self headerImageView].frame = CGRectMake(0, 0, self.bounds.size.width, self.yx_height);
    }
}


- (void)dealloc
{
    if ([self isInitial]) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
}
@end
