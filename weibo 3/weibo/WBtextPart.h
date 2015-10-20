//
//  WBtextPart.h
//  weibo
//
//  Created by xiong on 15/10/13.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBtextPart : NSObject
/** 这段文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 是否为特殊文字 */
@property (nonatomic, assign, getter = isSpecical) BOOL special;
/** 是否为表情 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end
