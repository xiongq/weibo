//
//  WBenlargerView.m
//  weibo
//
//  Created by xiong on 15/10/8.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBenlargerView.h"
#import "WBemotionBtn.h"
#import "UIView+Extension.h"


@interface WBenlargerView()
@property (weak, nonatomic) IBOutlet WBemotionBtn *eblargerBtn;

@end
@implementation WBenlargerView

+(instancetype)popview{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBenlargerView" owner:nil options:nil] lastObject];

}
-(void)showBtn:(WBemotionBtn *)button{
    if (button == nil) return;
    self.eblargerBtn.emotion = button.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    self.emotion = button.emotion;
    [window addSubview:self];
    
    CGRect rect = [button convertRect:button.bounds toView:nil];
    
    self.y = CGRectGetMidY(rect) - self.height;
    self.centerX = CGRectGetMidX(rect);
    

}


@end
