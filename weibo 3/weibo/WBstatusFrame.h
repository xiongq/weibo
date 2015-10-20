//
//  WBstatusFrame.h
//  weibo
//
//  Created by xiong on 15/9/23.
//  Copyright © 2015年 x. All rights reserved.
//
#define namefont [UIFont systemFontOfSize:15]
#define timefont [UIFont systemFontOfSize:10]
#define sourcefont [UIFont systemFontOfSize:10]
#define contentFont [UIFont systemFontOfSize:15]
#define reteetcontentFont [UIFont systemFontOfSize:13]
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WBstatus;
@interface WBstatusFrame : NSObject
@property (nonatomic, strong) WBstatus *status;
/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;


/** 转发微博的整体 */
@property (nonatomic, assign) CGRect retweetviewF;
/** 正文+昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/**  微博工具条*/
@property (assign, nonatomic) CGRect toolBarF;
/** 转发按键*/
@property (assign, nonatomic) CGRect retweetBtnF;
/** 评论按键*/
@property (assign, nonatomic) CGRect commentBtnF;
/** 点赞按键*/
@property (assign, nonatomic) CGRect unlikeF;
@end
