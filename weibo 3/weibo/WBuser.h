//
//  WBuser.h
//  weibo
//
//  Created by xiong on 15/9/19.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    WBUserVerifiedTypeNone = -1, // 没有任何认证
    
    WBUserVerifiedPersonal = 0,  // 个人认证
    
    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    WBUserVerifiedDaren = 220 // 微博达人
}WBUserVerifiedType;

@interface WBuser : NSObject
/** string idstr用户uid*/
@property(copy, nonatomic) NSString *idstr;
/** 用户名*/
@property(copy, nonatomic) NSString *name;
/** 会员类型 》2*/
@property(assign, nonatomic) int mbtype;
/** 会员等级*/
@property(assign, nonatomic) int mbrank;
@property(assign, nonatomic, getter=svip) BOOL vip;
/** 用户图像缩略图*/
@property(copy, nonatomic) NSString *profile_image_url;
@property(assign, nonatomic) WBUserVerifiedType verified_type;

@end
