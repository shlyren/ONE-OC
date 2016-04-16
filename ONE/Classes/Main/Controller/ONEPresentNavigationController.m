//
//  ONEPresentNavigationController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/16.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import "ONEPresentNavigationController.h"

@interface ONEPresentNavigationController ()

@end

@implementation ONEPresentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // 调用父类方法
//    [super pushViewController: viewController animated:animated];
//
//    
//    if (self.childViewControllers.count == 0)
//    {
//
//        self.navigationItem.leftBarButtonItem = self.setUpBackBarBtn;
//    }
//    
//}

//- (UIBarButtonItem *)setUpBackBarBtn
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"close_default_wight"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"close_highlighted"] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(dismisVc) forControlEvents:UIControlEventTouchUpInside];
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
//}



@end
