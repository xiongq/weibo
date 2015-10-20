
//  菜单
//  downMenu.m
//  weibo
//
//  Created by xiong on 15/9/1.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "downMenu.h"
#import "UIView+Extension.h"
@interface downMenu()
@property (weak, nonatomic) UIImageView *contentView;//灰色图像
@end

@implementation downMenu
/**
 *  懒加载
 *
 *  @return 灰色图像
 */
-(UIImageView *)contentView{
    if (!_contentView) {
        UIImageView *contentView = [[UIImageView alloc] init];
        contentView.image = [UIImage imageNamed:@"popover_background"];
        //contentView.width  = 217;
        //contentView.height = 217;
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//清除背景色
    }
    return self;
}
/**
 *  返回灰色图像
 *
 *  @return 返回灰色图像
 */
+(instancetype)downMenu{
    return [[self alloc]init];
}
/**
 *  创建遮盖
 *
 *  @param from 大小与window一样
 */
- (void)showFrom:(UIView *)from{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview: self];
    self.frame = window.bounds;
    //self.contentView.y = CGRectGetMaxY(from.frame) +20;
    CGRect newRect = [from.superview convertRect:from.frame toView:window];
    self.contentView.y = CGRectGetMaxY(newRect);
    self.contentView.centerX = CGRectGetMidX(newRect);
    //self.contentView.x = (self.width - self.contentView.width)*0.5;
}
/**
 *  移除
 */
- (void)remove{
    [self removeFromSuperview];
    
}
/**
 *  控制器set方法
 *
 *  @param contentController 传入的控制器
 */
-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;//引用防止reles
    self.content = contentController.view;
}
/**
 *  传入的uiview修改frame
 *
 *  @param content 传入的uiview
 */
- (void)setContent:(UIView *)content{
    _content = content;
    content.x = 10;
    content.y = 15;
    /**
     *  调整灰色图像的大小
     *
     *  @param content.frame 传入的view的大小
     *
     *  @return 修改尺寸
     */
    self.contentView.height = CGRectGetMaxY(content.frame) + 10;//灰色图像的高度等于传入view的最大高度+10
    //content.width = self.contentView.width - 2*content.x;//传入的view的宽度等于灰色图像的宽度-20 防止超出
    self.contentView.width = content.width + 20 ;//灰色图像的宽度 = 传入的view的宽度 + 边距
    [self.contentView addSubview:content];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   [self remove] ;
}
@end
