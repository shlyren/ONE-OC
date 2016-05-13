//
//  ONEMovieDetailItem.h
//  ONE
//
//  Created by 任玉祥 on 16/4/11.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEMovieDetailItem : NSObject
/*
  key            type   value
 
 revisedscore	String	0
 detailcover	String	http://image.wufazhuce.com/Fnfdl-Qt5GpQzKfw_I6dDgUfAQ7r
 maketime       String	2016-03-27 21:00:00
 keywords       String	兄弟伙，整起噻！;老板，毛肚来一盘！;重庆话，巴适！;瓜婆娘，么么哒！;沙坪坝草蜢
 video          String	http://music.wufazhuce.com/llDm2OuEtjaeyEhBptrGs4ddEbKL
 title          String	火锅英雄
 movie_id       String	277239172
 score          String	72
officialstory	String	在布满防空洞的重庆，三个从初中就“厮混”在一起的好兄弟合伙开着一家火锅店，名为“老同学洞子火锅”。由于经营不善，几人落得只能转让        店铺还债。为了店铺能“卖个好价钱”，三人打起了“扩充门面”的主意，自行往洞里开挖。没想到，在扩充工程中却凿开了银行的金库！就这样，濒临倒闭的火锅店和银行金库仅有“一洞之隔”；看着眼前随手可得的成堆现金，在“拿钱还是报案”的思想拉锯战中，三兄弟偶遇上另一个女同学——初中时给老大写过情书、现在在银行上班的于小惠。四个老同学因为这个“洞”而打开重聚之门。由此，这个略显尴尬的洞，引发了一个令人意想不到的故事……
 
 releasetime	String	2016-04-01 00:00:00
 read_num       String	198301
 review	S       tring	当前用户评分：78
                         满分人数占比：3.95%
                         90-99人数占比：23.64%
                         80-89人数占比：29.53%
                         70-79人数占比：27.07%
                         60-69人数占比：6.77%
                         50-59人数占比：2.55%
                         40-49人数占比：0.53%
                         30-39人数占比：0.62%
                         20-29人数占比：0.18%
                         10-19人数占比：0.35%
                         0-9人数占比：3.43%
                         负分人数占比：1.41%
 id             String	48
 indexcover     String	http://image.wufazhuce.com/FpW4ktC19rR8Kkw1FsIADCqCs_lo
 verse          String
 verse_en       String
 info           String      导演：杨庆
                            编剧： 杨庆
                            主演：陈坤/白百何/秦昊/喻恩泰
                            类型： 剧情
                            制片国家/地区：中国内地
 last_update_date	String	2016-03-31 12:06:19
 commentnum         Integer	469
 charge_edt         String	（责任编辑：朱洪）
 praisenum          Integer	0
 photo              Array
 servertime	I       nteger	1460355797
 sort               String	75
 scoretime           String	2016-04-02 00:00:00
 sharenum           Integer	687
 web_url            String	http://m.wufazhuce.com/movie/48
 */

@property (nonatomic, strong) NSString *revisedscore;

/** 顶部的图片 url */
@property (nonatomic, strong) NSString *detailcover;
/** 创建时间 */
@property (nonatomic, strong) NSString *maketime;
/** 关键字 */
@property (nonatomic, strong) NSString *keywords;
/** 视频url */
@property (nonatomic, strong) NSString *video;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 视频的id */
@property (nonatomic, strong) NSString *movie_id;
/** 分数 */
@property (nonatomic, strong) NSString *score;
/** 官方介绍 */
@property (nonatomic, strong) NSString *officialstory;
/** 更新时间 */
@property (nonatomic, strong) NSString *releasetime;
/** 阅读数 */
@property (nonatomic, strong) NSString *read_num;
/** 评分 */
@property (nonatomic, strong) NSString *review;
/** 服务器:id (就是获取电影列表的 moview_id) */
@property (nonatomic, strong) NSString *movie_detailId;
/** 电影列表展示的图片url */
@property (nonatomic, strong) NSString *indexcover;
/** 信息 */
@property (nonatomic, strong) NSString *info;
/** 最后更新时间 */
@property (nonatomic, strong) NSString *last_update_date;
/** 评论是 */
@property (nonatomic, assign) NSInteger commentnum;
/** 编辑人 */
@property (nonatomic, strong) NSString *charge_edt;
/** 喜欢数 */
@property (nonatomic, assign) NSInteger praisenum;
/** 照片url 数组 */
@property (nonatomic, strong) NSArray   *photo;

@property (nonatomic, assign) NSInteger servertime;
/** 种类 */
@property (nonatomic, strong) NSString *sort;
/** 评分时间 */
@property (nonatomic, strong) NSString *scoretime;
/** 分享数 */
@property (nonatomic, assign) NSInteger sharenum;
/** 网页版的url */
@property (nonatomic, strong) NSString *web_url;



@end
