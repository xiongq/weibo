//
//  WBemotionAttchment.m
//  weibo
//
//  Created by xiong on 15/10/9.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionAttchment.h"


@implementation WBemotionAttchment
-(void)setEmotion:(WBemotionModel *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];

}
@end
