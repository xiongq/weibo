//
//  downMenu.h
//  weibo
//
//  Created by xiong on 15/9/1.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface downMenu : UIView
+(instancetype)downMenu;
- (void)showFrom:(UIView *)from;//显示，参数uiview是点哪就显示在哪
- (void)remove;//移除
@property (strong, nonatomic) UIView *content;//传入的view
@property (strong, nonatomic) UIViewController *contentController;//传入的控制器
@end
