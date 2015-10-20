//
//  WBemotionPage.m
//  weibo
//
//  Created by xiong on 15/10/8.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionPage.h"
#import "WBemotionModel.h"
#import "UIView+Extension.h"
#import "NSString+Emoji.h"
#import "WBemotionBtn.h"
#import "WBenlargerView.h"
#import "WBemotionBtn.h"
#import "WBemotionTool.h"

@interface WBemotionPage()
@property (nonatomic, strong) WBenlargerView *enlargerView;
@property (nonatomic, weak) UIButton *deleteBtn;
@end
@implementation WBemotionPage
-(WBenlargerView *)enlargerView{
    if (!_enlargerView) {
        self.enlargerView = [WBenlargerView popview];
    }
    return _enlargerView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         *  删除按键
         */
        UIButton *deleteBtn = [UIButton new];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:) ]];
    }
    return self;
}
-(void)longPress:(UILongPressGestureRecognizer *)Recognizer{
    //手势位置
    CGPoint location = [Recognizer locationInView:Recognizer.view];
    WBemotionBtn *btn = [self emotionBtnWithLocation:location];
    
    switch (Recognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            //移除放大镜
            [self.enlargerView removeFromSuperview];
            if (btn) {
                //将手指所在的btn传入模型
                [self selectEmotion:btn.emotion];
            }
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            //显示放大镜
            [self.enlargerView showBtn:btn];
            
            break;
            
        default:
            break;
    }

}
-(void)selectEmotion:(WBemotionModel *)model{
    [WBemotionTool addRecentEmotion:model];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"emotion"] = model;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"emotionTouch" object:nil userInfo:dic];

}
/**
 * 计算手势滑动时 在那个按键，如果不在就返回nil
 *
 *  @param location 手指长按滑动时的位置
 *
 *  @return GRectContainsPoint判断一个cgpoint 是否在一个范围内
 */
-(WBemotionBtn *)emotionBtnWithLocation:(CGPoint)location{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        WBemotionBtn *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return  btn;
        }
    }
    return nil;
}
-(void)deleteClick{
    /**
     *  表情删除发出通知，接收注册在控制器
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteEmotion" object:nil];

}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
//    NSLog(@"%lu",(unsigned long)emotions.count);
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
       
        WBemotionBtn *btn = [[WBemotionBtn alloc] init];
//        btn.backgroundColor = [UIColor greenColor];
        [self addSubview:btn];
        btn.adjustsImageWhenHighlighted = NO;
         btn.emotion = emotions[i];
//        if (model.png) {
//            [btn setImage:[UIImage imageNamed:model.png] forState:UIControlStateNormal];
//        }else if (model.code){
//            [btn setTitle:model.code.emoji forState:UIControlStateNormal];
//            btn.titleLabel.font  = [UIFont systemFontOfSize:32];
//        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDragExit];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.emotions.count;
    CGFloat inset = 20;
    CGFloat btnW  =  (self.width - 2* inset )/ 7;
    CGFloat btnH  =  (self.height - inset )/ 3;
    
    for (int i = 0 ; i < count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = (i%7)*btnW + inset;
        btn.y = (i/7) *btnH + inset;
    }
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width - btnW - inset;
    self.deleteBtn.y = self.height - btnH;
   
}
-(void)click:(WBemotionBtn *)btn{
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    self.enlargerView.emotion = btn.emotion;
//    [window addSubview:self.enlargerView];
//    
//    CGRect rect = [btn convertRect:btn.bounds toView:nil];
//   
//    self.enlargerView.y = CGRectGetMidY(rect) - self.enlargerView.height;
//    self.enlargerView.centerX = CGRectGetMidX(rect);
    
//    [self.enlargerView showBtn:btn];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)),  dispatch_get_main_queue(), ^{
//        [self.enlargerView removeFromSuperview];
//    });
//
    [self selectEmotion:btn.emotion];
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    dic[@"emotion"] = btn.emotion;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"emotionTouch" object:nil userInfo:dic];
}
@end
