//
//  WBtabbar.m
//  weibo
//
//  Created by xiong on 15/9/2.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "WBtabbar.h"
#import "UIView+Extension.h"
@interface WBtabbar()
@property (weak, nonatomic)  UIButton *plusBtn;
@end

@implementation WBtabbar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];

    if (self) {
    UIButton *plusBtn = [[UIButton alloc] init];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(upside) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
-(void)upside{
    if ([self.newdelegate respondsToSelector:@selector(clickPlus:)]) {
        [self.newdelegate clickPlus:self];
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;
    CGFloat tabbatButtonW = self.width / 5;
    CGFloat tabbatButtonIndex = 0;
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbatButtonW;
            child.x = tabbatButtonW * tabbatButtonIndex;
            tabbatButtonIndex++;
            if (tabbatButtonIndex == 2) {
                tabbatButtonIndex++;
            }
        }
    }
}

@end
