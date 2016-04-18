//
//  ONESearchMovieItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/18.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONESearchMovieItem : NSObject
@property (nonatomic, strong) NSString *revisedscore;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *relesaetime;
/** id */
@property (nonatomic, strong) NSString *movie_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *scoretime;

@end
