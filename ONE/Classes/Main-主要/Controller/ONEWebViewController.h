//
//  ONEWebViewController.h
//  ONE
//
//  Created by JiaQi on 2016/12/3.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ONEWebViewController : UIViewController
@property (nonatomic, strong, readonly) NSString *url;

+ (instancetype)webViewControllerWithUrl:(NSString *)url;
@end
