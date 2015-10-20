//
//  WBemotionTool.m
//  weibo
//
//  Created by xiong on 15/10/10.
//  Copyright © 2015年 x. All rights reserved.
//
#define HWRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "WBemotionTool.h"

#import <MJExtension.h>

@implementation WBemotionTool
//全局变量，减少io操作
static NSMutableArray *_recentEmotion;

+(void)initialize{
    //懒加载，从沙盒中读取表情
    _recentEmotion  = [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];;
    if (_recentEmotion == nil) {
        _recentEmotion = [NSMutableArray new];
    }

}
+(WBemotionModel *)emotionWithChs:(NSString *)chs{
    NSArray *defaults = [self defaultEmotions];
    for (WBemotionModel *model in defaults) {
        if ([model.chs isEqualToString:chs]) {
            return model;
        }
    }
    NSArray *lxh = [self lxhEmotions];
    for (WBemotionModel *model in lxh) {
        if ([model.chs isEqualToString:chs]) {
            return model;
        }
    }
    return nil;
}

static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;
+(NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [WBemotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}
+(NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [WBemotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotions;
}
+(NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [WBemotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
    
}

+(NSArray *)recentEmotion{
    //    return [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];
    //返回沙盒中的表情数组
    return _recentEmotion;
}
+(void)addRecentEmotion:(WBemotionModel *)model{
//    NSMutableArray *emoion = (NSMutableArray *)[self recentEmotion];
//    if (emoion == nil) {
//        emoion = [NSMutableArray new];
//    }
//
    /**
     *  删除重复表情，重写iseqel
     */
    [_recentEmotion removeObject:model];
//    for (int i = 0 ; i < emoion.count; i++) {
//        WBemotionModel *models = emoion[i];
//        if ([models.chs isEqualToString:model.chs] || [models.code isEqualToString:model.code] ) {
//            [emoion removeObject:models];
//            break;
//        }
//    }
    /**
     *  删除重复表情，遍历数组删东西比较危险
     */
//    for (WBemotionModel *e in emoion) {
//        if ([e.chs isEqualToString:model.chs] || [e.code isEqualToString:model.code] ) {
//            [emoion removeObject:e];
//            break;
//        }
//    }
    //将表情插入到最前面
    [_recentEmotion insertObject:model atIndex:0];
    //写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotion toFile:HWRecentEmotionsPath];

}

@end
