//
//  WBemotionTextView.h
//  weibo
//
//  Created by xiong on 15/10/9.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBtextView.h"
@class WBemotionModel;

@interface WBemotionTextView : WBtextView
-(void)insertEmotion:(WBemotionModel *)emotion;
-(NSString *)fulltext;
@end
