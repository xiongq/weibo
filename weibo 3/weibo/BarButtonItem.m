//
//  BarButtonItem.m
//  weibo
//
//  Created by xiong on 15/8/29.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "BarButtonItem.h"
#import "UIView+Extension.h"

@implementation BarButtonItem
+ (UIBarButtonItem *)testTarget:(id)target action: (SEL)action Image:(NSString *)Image Imagehighlighted: (NSString *)Imagehighlighted{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn addTarget:target action:action  forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [Btn setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:Imagehighlighted] forState:UIControlStateHighlighted];
    // 设置尺寸
    Btn.size = Btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}
@end
