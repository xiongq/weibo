//
//  WBenlargerView.h
//  weibo
//
//  Created by xiong on 15/10/8.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  WBemotionModel,WBemotionBtn;

@interface WBenlargerView : UIView
+(instancetype)popview;
-(void)showBtn:(WBemotionBtn *)button;
//@property (nonatomic, strong) WBemotionModel *emotion;
@end

