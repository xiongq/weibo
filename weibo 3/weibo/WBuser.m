//
//  WBuser.m
//  weibo
//
//  Created by xiong on 15/9/19.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBuser.h"

@implementation WBuser
-(void)setMbrank:(int )mbrank{
    _mbrank = mbrank;
    self.vip = mbrank > 2;
}
@end
