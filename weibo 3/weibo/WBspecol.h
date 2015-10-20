//
//  WBspecol.h
//  weibo
//
//  Created by xiong on 15/10/14.
//  Copyright © 2015年 x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBspecol : NSObject
/** 这段文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSArray *rects;
@end
