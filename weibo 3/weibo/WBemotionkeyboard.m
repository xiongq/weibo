//
//  WBemotionkeyboard.m
//  weibo
//
//  Created by xiong on 15/10/5.
//  Copyright © 2015年 x. All rights reserved.
//  尝试git1

#import "WBemotionkeyboard.h"
#import "WBemotionListView.h"
#import "WBemotionTarBar.h"
#import "UIView+Extension.h"
#import <MJExtension.h>
#import "WBemotionModel.h"
#import "WBemotionTool.h"

@interface WBemotionkeyboard() <WBemotionTarBarDelegate>
@property (nonatomic, weak) WBemotionListView *shiwingListView;
@property (strong, nonatomic) WBemotionListView *noneEmotionListView;
@property (strong, nonatomic) WBemotionListView *defulEmotionListView;
@property (strong, nonatomic) WBemotionListView *emojiEmotionListView;
@property (strong, nonatomic) WBemotionListView *lxhEmotionListView;
@property (strong, nonatomic) WBemotionTarBar   *emotionTarBar;
@end

@implementation WBemotionkeyboard

-(WBemotionListView *)noneEmotionListView{
    if (!_noneEmotionListView) {
        _noneEmotionListView = [[WBemotionListView alloc] init];
        _noneEmotionListView.emotion = [WBemotionTool recentEmotion];
    }
    return _noneEmotionListView;
}
-(WBemotionListView *)defulEmotionListView{
    if (!_defulEmotionListView) {
        _defulEmotionListView = [[WBemotionListView alloc] init];
        _defulEmotionListView.emotion = [WBemotionTool defaultEmotions];
    }
    return _defulEmotionListView;
}
-(WBemotionListView *)emojiEmotionListView{
    if (!_emojiEmotionListView) {
        _emojiEmotionListView = [[WBemotionListView alloc] init];
        _emojiEmotionListView.emotion = [WBemotionTool emojiEmotions];
    }
    return _emojiEmotionListView;
}
-(WBemotionListView *)lxhEmotionListView{
    if (!_lxhEmotionListView) {
        _lxhEmotionListView = [[WBemotionListView alloc] init];
        _lxhEmotionListView.emotion = [WBemotionTool lxhEmotions];
    }
    return _lxhEmotionListView;

}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    self.emotionTarBar   = [[WBemotionTarBar alloc] init];
    self.emotionTarBar.delegate = self;
    [self addSubview:self.emotionTarBar];
        /**
         *  表情通知
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchEmotion:) name:@"emotionTouch" object:nil];
    }
    return self;
    
}

-(void)touchEmotion:(NSNotification *)notifaca{
    self.noneEmotionListView.emotion = [WBemotionTool recentEmotion];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.emotionTarBar.width = self.width;
    self.emotionTarBar.height = 37;
    self.emotionTarBar.x = 0;
    self.emotionTarBar.y = self.height - self.emotionTarBar.height;
    
    self.shiwingListView.x = self.shiwingListView.y = 0;
    self.shiwingListView.width = self.width;
    self.shiwingListView.height = self.emotionTarBar.y;
}
-(void)WBemotion:(WBemotionTarBar *)emotionTarbar emotionType:(WBemotionTarBarType)type{
    /**
     *  移除之前显示的内容
     */
    [self.shiwingListView removeFromSuperview];
//    [_shiwingListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (type) {
        case WBemotionTarBarTypeNone:{
//            NSLog(@"最近");
            [self addSubview:self.noneEmotionListView];
            break;
        }
            
        case WBemotionTarBarTypeDefule:{
            [self addSubview:self.defulEmotionListView];
//            NSLog(@"默认");
            break;
        }
            
        case WBemotionTarBarTypeEmoji:{
            [self addSubview:self.emojiEmotionListView];
//            NSLog(@"Emoji");
            break;
        }
            
        case WBemotionTarBarTypeLxh:{
            [self addSubview:self.lxhEmotionListView];
//            NSLog(@"浪小花");
            break;
        }
            
    }
 
    /**
     *  取出view中最后一个子控件赋值
     */
    self.shiwingListView = [self.subviews lastObject];
    /**
     *  会再执行一layoutSubviews ，设置其frame
     */
    [self setNeedsLayout];

}
@end
