//
//  WBbutton.m
//  weibo
//
//  Created by xiong on 15/9/18.
//  Copyright © 2015年 x. All rights reserved.
//  导航栏中间按钮

#import "WBbutton.h"
#import "UIView+Extension.h"

@implementation WBbutton
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    frame.size.width += 10;
    [super setFrame:frame];
    

}


-(void)layoutSubviews{
    [super layoutSubviews];
    /**
     *  注释掉代码有bug，可能造成启动时位置变化
     */
    //self.titleLabel.x = self.imageView.x;
    //self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    self.titleLabel.x = self.titleLabel.x - self.imageView.width;
    self.imageView.x = self.titleLabel.x + self.titleLabel.width +10;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}


@end
