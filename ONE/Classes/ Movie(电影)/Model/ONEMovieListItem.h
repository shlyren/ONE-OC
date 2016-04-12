//
//  ONEMovieListItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEMovieListItem : NSObject


/** <#注释#> */
@property (nonatomic, strong) NSString *revisedscore;

/** <#注释#> */
@property (nonatomic, strong) NSString *cover;

/**  */
@property (nonatomic, strong) NSString *score;

/** <#注释#> */
@property (nonatomic, strong) NSString *releasetime;

/** <#注释#> */
@property (nonatomic, strong) NSString *servertime;

/** <#注释#> */
@property (nonatomic, strong) NSString *movie_id; // 服务器 id

/** n*/
@property (nonatomic, strong) NSString *verse;

/** <#注释#> */
@property (nonatomic, strong) NSString *title;

/** <#注释#> */
@property (nonatomic, strong) NSString *scoretime;

/** <#注释#> */
@property (nonatomic, strong) NSString *verse_en;
@end
