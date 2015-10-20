//
//  WBcomposeToolBar.m
//  weibo
//
//  Created by xiong on 15/10/3.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBcomposeToolBar.h"
#import "UIView+Extension.h"

@interface WBcomposeToolBar ()
@property (weak,nonatomic) UIButton *emotionBtn;
@end
@implementation WBcomposeToolBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
//    [UIImage imageNamed:@"compose_keyboardbutton_background"]
    if (self) {
     
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    [self setImage:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" type:WBcomposeToolBarButtonTypeCamera];
    [self setImage:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" type:WBcomposeToolBarButtonTypePicture];
    [self setImage:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" type:WBcomposeToolBarButtonTypeMention];
    [self setImage:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" type:WBcomposeToolBarButtonTypeTrend];
        
   self.emotionBtn = [self setImage:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" type:WBcomposeToolBarButtonTypeEmotion];
    }
    return self;
}

-(void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    /**
     *  默认图片是表情
     */
    NSString *imageName = @"compose_emoticonbutton_background";
    NSString *hightName = @"compose_emoticonbutton_background_highlighted";
    if (showKeyboard) {//如果是yes，默认图片就改为键盘图标
        imageName = @"compose_keyboardbutton_background";
        hightName = @"compose_keyboardbutton_background_highlighted";
    }
    //设置图标
    [self.emotionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageNamed:hightName] forState:UIControlStateHighlighted];
}

- (UIButton *)setImage:(NSString *)image hightImage:(NSString *)hightImage type:(WBcomposeToolBarButtonType)type{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat toolBtnWidth = self.width / count;
    for (int i = 0; i< count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * toolBtnWidth;
        btn.width = toolBtnWidth;
        btn.height = self.height;
    }
    
}
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didclickButton:)]) {
        [self.delegate composeToolBar:self didclickButton:(int)(btn.tag)];
    }
}
@end
