//
//  ONEFPSLabel.m
//  ONE
//
//  Created by 任玉祥 on 16/4/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ONEFPSLabel.h"
@interface ONEFPSLabel()

@property (nonatomic, strong) CADisplayLink     *link;

@property (nonatomic, assign) NSUInteger        count;

@property (nonatomic, assign) NSTimeInterval    lastTime;

@end


@implementation ONEFPSLabel

NSString *const ONEFPSLabelXKey = @"ONEFPSLabelXKey";
NSString *const ONEFPSLabelYKey = @"ONEFPSLabelYKey";
NSString *const ONEFPSLabelIsPan = @"ONEFPSLabelIsPan";

+ (instancetype)shareInstance
{
    static ONEFPSLabel *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });
    return _instance;
}

+ (void)setupFPSLabel
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:ONEFPSLabelKey]) {
        [self showFPSLabel];
    }else {
        [self hiddenFPSLabel];
    }
}

+ (void)showFPSLabel
{
    [[UIApplication sharedApplication].keyWindow addSubview:[self shareInstance]];
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:ONEFPSLabelKey];
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self shareInstance] setAlpha:1];
    }];
}

+ (void)hiddenFPSLabel
{
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:ONEFPSLabelKey];
    [UIView animateWithDuration:0.5 animations:^{
        [[self shareInstance] setAlpha:0];
    } completion:^(BOOL finished) {
        [[self shareInstance] removeFromSuperview];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{

    CGFloat x = [[NSUserDefaults standardUserDefaults] floatForKey:ONEFPSLabelXKey];
    CGFloat y = [[NSUserDefaults standardUserDefaults] floatForKey:ONEFPSLabelYKey];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:ONEFPSLabelIsPan]) {
        x = 20;
        y = ONEScreenHeight - 50;
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:ONEFPSLabelIsPan];
        [[NSUserDefaults standardUserDefaults] setFloat:x forKey:ONEFPSLabelXKey];
        [[NSUserDefaults standardUserDefaults] setFloat:y forKey:ONEFPSLabelYKey];
    }

    if (self = [super initWithFrame: CGRectMake(x, y, 55, 20)])
    {
        [self setupPoint];
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = true;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = false;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha: 0.7];
        self.font = [UIFont fontWithName: @"Menlo" size: 14];
        self.userInteractionEnabled = true;
        self.alpha = 0;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        __weak typeof(self) weakSelf = self;
        self.link = [CADisplayLink displayLinkWithTarget:weakSelf selector: @selector(tick:)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
    }
    
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{

    CGPoint point = [pan translationInView:pan.view];
    
    CGPoint center = self.center;
    center.x += point.x;
    center.y += point.y;
    self.center = center;

    if (pan.state == UIGestureRecognizerStateEnded)
    {
        [[NSUserDefaults standardUserDefaults] setFloat:center.x forKey:ONEFPSLabelXKey];
        [[NSUserDefaults standardUserDefaults] setFloat:center.y forKey:ONEFPSLabelYKey];
       
        [self setupPoint];
        
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)setupPoint
{
    if (self.x < 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.x = 0;
        }];
    } else if (CGRectGetMaxX(self.frame) > ONEScreenWidth) {
        [UIView animateWithDuration:0.2 animations:^{
            self.x = ONEScreenWidth - 55;
        }];
    }
    
    if (self.y < 20) {
        [UIView animateWithDuration:0.2 animations:^{
            self.y = 20;
        }];
    } else if (CGRectGetMaxY(self.frame) > ONEScreenHeight - 20) {
        [UIView animateWithDuration:0.2 animations:^{
            self.y = ONEScreenHeight - 40;
        }];
    }
}

- (void)tick:(CADisplayLink *)link
{
    if (self.lastTime == 0)
    {
        self.lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval delta = link.timestamp - self.lastTime;

    if (delta < 1) return;
    self.lastTime = link.timestamp;
    double fps = self.count / delta;
    _count = 0;

    CGFloat progress = fps / 60.0;
    self.textColor = [UIColor colorWithHue: 0.27 * (progress - 0.2) saturation: 1 brightness: 0.9 alpha: 1];
    self.text = [NSString stringWithFormat: @"%zdFPS", (NSInteger)(fps + 0.5)];
}


@end
