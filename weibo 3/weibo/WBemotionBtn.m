//
//  WBemotionBtn.m
//  weibo
//
//  Created by xiong on 15/10/8.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionBtn.h"
#import "WBemotionModel.h"
#import "NSString+Emoji.h"


@implementation WBemotionBtn
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
-(void)setEmotion:(WBemotionModel *)emotion{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if (emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
//        [self setup];
    }

}
-(void)setup{
    self.titleLabel.font = [UIFont systemFontOfSize:32];

}
@end
