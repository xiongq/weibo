//
//  nilHightButton.m
//  weibo
//
//  Created by xiong on 15/10/6.
//  Copyright © 2015年 x. All rights reserved.
//

#import "nilHightButton.h"

@implementation nilHightButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{


}

@end
