//
//  WBstatus.h
//  weibo
//
//  Created by xiong on 15/9/19.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBuser;

@interface WBstatus : NSObject
/** string 微博id*/
@property(copy, nonatomic) NSString *idstr;
/** string 微博内容*/
@property(copy, nonatomic) NSString *text;
/** 带属性微博内容*/
@property(copy, nonatomic) NSAttributedString  *AttributedStringText;
/** string 时间*/
@property(copy, nonatomic) NSString *created_at;
/** string 微博来源*/
@property(copy, nonatomic) NSString *source;
/** string 微博作者*/
@property(strong, nonatomic) WBuser *user;
/** string 微博配图，多图片链接，没有返回[]*/
@property(strong, nonatomic) NSArray *pic_urls;
/** 转发的微博*/
@property(strong, nonatomic) WBstatus *retweeted_status;
/** 转发带属性微博内容*/
@property(copy, nonatomic) NSAttributedString  *retweeted_statusText;
/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
