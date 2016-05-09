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

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size = CGSizeMake(55, 20);
    
    if (self = [super initWithFrame: frame])
    {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = false;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.7];
        self.font = [UIFont fontWithName: @"Menlo" size: 14];
        __weak typeof(self) weakSelf = self;
        self.link = [CADisplayLink displayLinkWithTarget: weakSelf selector: @selector(tick:)];
        [self.link addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
    }
    
    return self;
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
