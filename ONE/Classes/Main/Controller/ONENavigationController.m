//
//  ONENavigationController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/1.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONENavigationController.h"
#import "SVProgressHUD.h"

@interface ONENavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) UIImage *backgroudImage;
@end

@implementation ONENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = false;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
   
    _shadowImage = self.navigationBar.shadowImage;
    _backgroudImage = [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count)
    {
        viewController.hidesBottomBarWhenPushed = true;
        viewController.navigationItem.leftBarButtonItem = self.setUpBackBarBtn;
        
    }else {// 当子控制器的个数==0 的时候, 表示暂定控制器是跟控制器, 设置导航条的item
        
        // 创建右侧tabbItem
        UIBarButtonItem *leftBtn = [self setUpNavigationItemImage:@"nav_search_default" target:self action:@selector(leftBtnClick)];
        viewController.navigationItem.leftBarButtonItem = leftBtn;
        
         // 创建右侧tabbItem
        UIBarButtonItem *rightBtn = [self setUpNavigationItemImage:@"nav_me_default" target:self action:@selector(rightBtnClick)];
        viewController.navigationItem.rightBarButtonItem = rightBtn;
        
    }
    
    // 调用父类方法
    [super pushViewController: viewController animated:animated];
}

// 初始化跟控制器导航条的item
- (UIBarButtonItem *)setUpNavigationItemImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    //创建右侧按钮
    UIButton *btn = [UIButton new];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 设置frame
    btn.frame = CGRectMake(0, 0, 20, 20);
    
    // 添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}


#pragma mark - Events
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{}

- (void)leftBtnClick
{
    ONELogFunc;
}

- (void)rightBtnClick
{
    ONELogFunc;
}

- (UIBarButtonItem *)setUpBackBarBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)popViewController
{
    [self popViewControllerAnimated:true];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
   [SVProgressHUD dismiss];
   return [super popViewControllerAnimated:animated];
}

@end
