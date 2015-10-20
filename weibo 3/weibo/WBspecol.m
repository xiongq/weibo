//
//  WBspecol.m
//  weibo
//
//  Created by xiong on 15/10/14.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBspecol.h"

@implementation WBspecol
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
