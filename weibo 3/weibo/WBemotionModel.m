//
//  WBemotionModel.m
//  weibo
//
//  Created by xiong on 15/10/7.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionModel.h"

@interface WBemotionModel() <NSCoding>
@end
@implementation WBemotionModel

//读沙盒
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.chs = [aDecoder decodePropertyListForKey:@"chs"];
        self.png = [aDecoder decodePropertyListForKey:@"png"];
        self.code = [aDecoder decodePropertyListForKey:@"code"];
    }
    return self;
}

//写沙盒
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];

}
/**
 *  [emoion removeObject:model];就会调用该方法比较，只是比较其内存地址是否相同；
 *
 *  @param object object 传入的模型
 *
 *  @return return yes？no
 */

-(BOOL)isEqual:(WBemotionModel *)object{
    if ([self.chs isEqualToString:object.chs]||[self.code isEqualToString:object.code]) {
        return YES;
    }else{
        return NO;
    }

}
@end
