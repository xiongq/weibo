//
//  WBtextPart.m
//  weibo
//
//  Created by xiong on 15/10/13.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBtextPart.h"

@implementation WBtextPart
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
