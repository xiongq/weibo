//
//  WBemotionTool.h
//  weibo
//
//  Created by xiong on 15/10/10.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBemotionModel.h"

//@class WBemotionModel;
@interface WBemotionTool : NSObject
+(void)addRecentEmotion:(WBemotionModel *)model;
+ (NSArray *)recentEmotion;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

+(WBemotionModel *)emotionWithChs:(NSString *)chs;
@end
