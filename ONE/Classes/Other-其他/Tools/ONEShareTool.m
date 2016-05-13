//
//  ONEShareTool.m
//  ONE
//
//  Created by 任玉祥 on 16/5/12.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEShareTool.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"


// 5733f154e0f55a7bbb00041b

@interface ONEShareTool ()<UMSocialUIDelegate>

@end


@implementation ONEShareTool

+ (instancetype)shareTool
{
    return [self new];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    static ONEShareTool *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

#pragma mark - 公共方法
+ (void)setupShareTool
{
    [[self shareTool] setupShareTool];
}

+ (void)showShareView:(UIViewController *)controller content:(NSString *)content url:(NSString *)url image:(UIImage *)image
{
    [[ONEShareTool shareTool] showShareView:controller
                                    content:content
                                        url:url
                                      image:image];
}


+ (BOOL)handleOpenURL:(NSURL *)url
{
    return [[self shareTool] handleOpenURL:url];
}

#pragma mark - UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享平台名
        ONELog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


#pragma mark - 私有方法
- (void)showShareView:(UIViewController *)controller content:(NSString *)content url:(NSString *)url image:(UIImage *)image
{
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:@"5733f154e0f55a7bbb00041b"
                                      shareText:content
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,
                                                  UMShareToWechatSession,
                                                  UMShareToWechatTimeline,
                                                  UMShareToQQ,
                                                  UMShareToQzone,
                                                  UMShareToTencent,
                                                  UMShareToAlipaySession,
                                                  UMShareToTwitter]
                                       delegate:self];
    
//    设置点击分享内容跳转链接
    // QQ QQ空间
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialData defaultData].extConfig.qzoneData.url = url;
    // 微信 微信朋友圈
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
}

- (void)setupShareTool
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"5733f154e0f55a7bbb00041b"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx6b17c5d92db3dc28"
                            appSecret:@"9cb5f77b3e93f901e2f9a37ebb60b586"
                                  url:@"http://www.umeng.com/social"];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105396018"
                               appKey:@"eRhWnZSETGklE9fh"
                                  url:@"http://www.umeng.com/social"];
    
    
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3119175926"
                                              secret:@"847ba64e61a99342dab6613b7634ac50"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

 @end
