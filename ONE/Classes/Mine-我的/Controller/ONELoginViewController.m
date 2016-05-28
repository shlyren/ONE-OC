//
//  ONELoginViewController.m
//  ONE
//
//  Created by 任玉祥 on 16/4/21.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONELoginViewController.h"
#import "SVProgressHUD.h"
#import "ONEURLConst.h"

@interface ONELoginViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgrouImage;

@end

@implementation ONELoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView
{
    self.backgrouImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg_%02zd", (NSInteger)arc4random_uniform(10)]];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.protocolLabel.text];
    NSRange contentRange = {0,content.length};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.protocolLabel.attributedText = content;
    [self.protocolLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelClick)]];

}

- (IBAction)loginTitleClick
{
    [self setupWebViewControllerTitle:@"任玉祥" url:@"http://shlyren.com"];
}

- (void)protocolLabelClick
{
    [self setupWebViewControllerTitle:@"用户协议" url:procotolUrl];
}

#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [SVProgressHUD show];
    return true;
}

- (void)setupWebViewControllerTitle:(NSString *)title url:(NSString *)urlStr
{
    UIViewController *protocolVc = [UIViewController new];
    protocolVc.title = title;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:protocolVc.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    webView.delegate = self;
    [protocolVc.view addSubview:webView];
    
    [self.navigationController pushViewController:protocolVc animated:true];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加载失败..."];
}

- (IBAction)closeBtnClick
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
