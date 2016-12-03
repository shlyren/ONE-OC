//
//  ONEWebViewController.m
//  ONE
//
//  Created by JiaQi on 2016/12/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEWebViewController.h"
@import WebKit;
#import "JQAlertView.h"
#import "ONEShareTool.h"
#import "UIImage+image.h"

/** 网页加载进度的Key */
#define kEstimatedProgressKey @"estimatedProgress"

/** 动画时间 */
#define kDurationTime 0.3f

@interface ONEWebViewController ()<WKNavigationDelegate, UIScrollViewDelegate>

/** webView */
@property (nonatomic, weak) WKWebView                   *webView;
/** 占位View */
@property (weak, nonatomic) IBOutlet UIView             *contentView;
/** 进度条progressView */
@property (weak, nonatomic) IBOutlet UIProgressView     *progressView;
/** 网页控制器的view */
@property (weak, nonatomic) IBOutlet UIView             *controlView;
/** 网页控制器左边的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlViewLeft;
/** 返回按钮 */
@property (weak, nonatomic) IBOutlet UIButton           *goBackBtn;
/** 重新加载／取消加载 按钮 */
@property (weak, nonatomic) IBOutlet UIButton           *reloadBtn;

@property (nonatomic, strong) NSString                  *urlstr;
@end

@implementation ONEWebViewController
+ (instancetype)webViewControllerWithUrl:(NSString *)url
{
    ONEWebViewController *vc = [ONEWebViewController new];
    vc.urlstr = url;
    return vc;
}

- (NSString *)url
{
    return self.urlstr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNav];
    
    // 初始化页面
    [self setupView];
}

#pragma mark - 初始化导航栏
- (void)setupNav
{

    self.title = @"加载中...";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"action"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
}

- (void)share
{
    
    [JQAlertView showAlertViewWithTitle:nil message:nil preferredStyle:JQAlertViewStyleActionSheet titles:@[@"分享", @"在Safari中打开", @"复制网址"] destructiveTitle:nil cancelTitle:@"取消" handler:^(JQAlertView * _Nonnull alertView, NSInteger index) {
        if (index == 0) {
            [ONEShareTool showShareView:self content:self.title url:[NSString stringWithFormat:@"%@", self.webView.URL] image:[UIImage imageNamed:@"avatar"]];
        }else if (index == 1) {
            if ([[UIApplication sharedApplication] canOpenURL:self.webView.URL]) {
                [[UIApplication sharedApplication] openURL:self.webView.URL];
            }
        }else if (index == 2) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = [NSString stringWithFormat:@"%@", self.webView.URL];
        }
    }];
}


#pragma mark - 初始化页面
- (void)setupView
{
    self.controlViewLeft.constant = -50;
    
    for (UIView *view in self.controlView.subviews)
    {
        if (![view isKindOfClass:[UIButton class]]) continue;
        UIButton *btn = (UIButton *)view;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.85 alpha:0.6]] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = true;
    }
    
    // 1、创建webView
    WKWebView *webView = [[WKWebView alloc] initWithFrame: self.view.bounds];
    {
        webView.scrollView.delegate = self;
        [self.contentView addSubview: webView];
        
        // 主要实现了涉及到导航跳转方面的回调方法
        webView.navigationDelegate = self;
        webView.scrollView.delegate = self;
        _webView = webView;
    }
    
    // 2、加载请求
    [webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:self.url]]];
    
    // 3、为webView添加进度条通知
    [webView addObserver: self forKeyPath: kEstimatedProgressKey options: NSKeyValueObservingOptionNew context: nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.webView.scrollView.delegate = nil;
    self.webView.navigationDelegate = nil;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.contentView.bounds;
}

- (IBAction)goback
{
    if ([self.webView canGoBack])[self.webView goBack];
}


- (IBAction)reload
{
    if (self.reloadBtn.isSelected)
    {
        [self.webView stopLoading];
    }else{
        [self.webView reload];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = !self.reloadBtn.isSelected;
    
    self.reloadBtn.selected = !self.reloadBtn.isSelected;
}


#pragma mark - WKNavigationDelegate
#pragma mark 页面加载完成后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.goBackBtn.enabled = webView.canGoBack;
    self.reloadBtn.selected = false;
    
    // 获取 id = 'media'的 aduio节点，并播放
    [webView evaluateJavaScript: @"var audio = document.getElementById('media'); audio.play();" completionHandler: nil];
    self.title = webView.title;

    [self showControl];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}


#pragma mark 网页加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.reloadBtn.selected = false;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

#pragma mark 开始加载网页调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.reloadBtn.selected = true;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1.0;
}

#pragma mark scrollview 将要拖拽的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self disMissControll];
}

#pragma mark scrollview 停止拖拽的时候
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self showControl];
}

- (void)showControl
{
    if (self.controlViewLeft.constant == 10) return;
    
    self.controlViewLeft.constant = 10;
    [UIView animateWithDuration:kDurationTime delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)disMissControll
{
    if (self.controlViewLeft.constant == -50) return;
    
    self.controlViewLeft.constant = -50;
    [UIView animateWithDuration:kDurationTime animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    // 移除进度条通知
    [self.webView removeObserver: self forKeyPath: kEstimatedProgressKey];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}



@end
