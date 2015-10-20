//
//  WBemotionTarBar.m
//  weibo
//
//  Created by xiong on 15/10/5.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionTarBar.h"
#import "UIView+Extension.h"
#import "nilHightButton.h"

@interface WBemotionTarBar ()

//@property (nonatomic, weak) nilHightButton *seleBTN;
@property (nonatomic, weak) nilHightButton *seleBTN;
@end

@implementation WBemotionTarBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBtn:@"最近"   btnType:WBemotionTarBarTypeNone];
        [self setBtn:@"默认"   btnType:WBemotionTarBarTypeDefule];
        [self setBtn:@"Emoji" btnType:WBemotionTarBarTypeEmoji];
        [self setBtn:@"浪小花" btnType:WBemotionTarBarTypeLxh];
    }
    return self;
}

-(nilHightButton *)setBtn:(NSString *)title btnType:(WBemotionTarBarType)type{
    nilHightButton *Btn = [[nilHightButton alloc] init];
    Btn.tag = type;
//    if (type == WBemotionTarBarTypeDefule) {
//        [self click:Btn];
//    }

    [Btn setTitle:title forState:UIControlStateNormal];

    [Btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [Btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateDisabled];
    [Btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
    [self addSubview:Btn];
    return Btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageH = 37;
    for (int i = 0; i < count; i++) {
        nilHightButton *btn = self.subviews[i];
        NSUInteger col = i %maxCol;
        btn.x = col * (self.width/maxCol);
        btn.y = 0;
        btn.width = self.width/maxCol;
        btn.height = imageH;
    }
    
    
}
-(void)setDelegate:(id<WBemotionTarBarDelegate>)delegate{
    _delegate = delegate;
    [self click:(nilHightButton *)[self viewWithTag:WBemotionTarBarTypeDefule]];
}
-(void)click:(nilHightButton *)btn{
    self.seleBTN.enabled = YES;
    btn.enabled = NO;
    self.seleBTN = btn;
    if ([self.delegate respondsToSelector:@selector(WBemotion:emotionType:)]){
        [self.delegate WBemotion:self emotionType:(int)btn.tag];
    }
}
@end
