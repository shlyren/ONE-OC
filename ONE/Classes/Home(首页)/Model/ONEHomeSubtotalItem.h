//
//  ONEHomeSubtotalItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/15.
//  Copyright © 2016年 ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "hpcontent_id"         :"1310",
 "hp_title"             :"VOL.1287",
 "author_id"            :"-1",
 "hp_img_url"           :"http://image.wufazhuce.com/FvQ83yI_b00Ng3sJvl-2kfIP1QTt",
 "hp_img_original_url"  :"http://image.wufazhuce.com/FvQ83yI_b00Ng3sJvl-2kfIP1QTt",
 "hp_author"            :"铁塔下的舞会&NicoGuo 作品",
 "ipad_url"             :"http://image.wufazhuce.com/Fglf71IV_tSI40lLWY34wLiFgkFh",
 "hp_content"           :"很多少年刚开始的时候多么的特立独行啊，最后都要为一个女孩而平庸。by 孔龙",
 "hp_makettime"         :"2016-04-15 21:00:00", //
 "last_update_date"     :"2016-04-08 13:10:43",
 "web_url"              :"http://m.wufazhuce.com/one/1310",
 "wb_img_url"               :"",
 "praisenum"            :5117,
 "sharenum"         :682,
 "commentnum"           :252
 */
@interface ONEHomeSubtotalItem : NSObject

@property (nonatomic, strong) NSString *hpcontent_id;
@property (nonatomic, strong) NSString *hp_title;
@property (nonatomic, strong) NSString *author_id;
@property (nonatomic, strong) NSString *hp_img_url;
@property (nonatomic, strong) NSString *hp_img_original_url;
@property (nonatomic, strong) NSString *hp_author;
@property (nonatomic, strong) NSString *ipad_url;
@property (nonatomic, strong) NSString *hp_content;
@property (nonatomic, strong) NSString *hp_makettime;
@property (nonatomic, strong) NSString *last_update_date;
@property (nonatomic, strong) NSString *web_url;
@property (nonatomic, strong) NSString *praisenum;
@property (nonatomic, strong) NSString *sharenum;
@property (nonatomic, strong) NSString *commentnum;

@end
