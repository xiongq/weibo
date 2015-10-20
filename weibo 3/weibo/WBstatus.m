//
//  WBstatus.m
//  weibo
//
//  Created by xiong on 15/9/19.
//  Copyright © 2015年 x. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WBstatus.h"
#import <MJExtension.h>
#import "WBuser.h"
#import "WBphoto.h"
#import "RegexKitLite.h"
#import "WBtextPart.h"
#import "WBemotionTool.h"
#import "WBspecol.h"

//#import "MJExtension.h"

@implementation WBstatus
+(NSDictionary *)objectClassInArray{
    
    return @{@"pic_urls":[WBphoto class]};
}
#warning bug timelabel'width;
/**
 *  转时间，还有个bug，需要重新计算label的宽度，目前是+10解决
 *
 */
-(void)setText:(NSString *)text{
    _text = [text copy];
    self.AttributedStringText = [self AttributedStringText:text];
}
-(NSAttributedString *)AttributedStringText:(NSString *)text{
    NSMutableAttributedString *attri = [NSMutableAttributedString new];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"([hH][tT][tT][pP][sS]?:\\/\\/[^ ,'\">\\]\\)]*[^\\. ,'\">\\]\\)])";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    NSMutableArray *parts = [NSMutableArray new];
    NSMutableArray *specials  = [NSMutableArray new];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return;
        }
        WBtextPart *part = [WBtextPart new];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] &&[part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return ;
        }
        WBtextPart *part = [WBtextPart new];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    [parts sortUsingComparator:^NSComparisonResult(WBtextPart *obj1, WBtextPart *obj2) {
        if (obj1.range.location > obj2.range.location) {
            return NSOrderedDescending;//降序(只限于这两个比较结果的排列，容易混淆)意思是如果no1 》 no2 no1和no2是降序反之未升序
        }
        return NSOrderedAscending;//升序
    } ];
    UIFont *font = [UIFont systemFontOfSize:15];
    for (WBtextPart *part in parts) {
        NSAttributedString *str = nil;
        if (part.isEmotion) {
            //表情
            NSTextAttachment *attch = [NSTextAttachment new];
            NSString *name = [WBemotionTool emotionWithChs:part.text].png;
            
            if (name) {
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                str = [NSAttributedString attributedStringWithAttachment:attch];
            }else{
                str = [[NSAttributedString alloc] initWithString:part.text];
            }
           
        }else if(part.isSpecical){
            //高亮
            str = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                   NSForegroundColorAttributeName:
                                                                                       [UIColor brownColor]
             
                                                                                   }];
            //将高亮的文字 放入模型，再放入数组中
            WBspecol *specol = [WBspecol new];
            specol.text = part.text;
            NSUInteger loc = attri.length;
            NSUInteger len = part.text.length;
            specol.range = NSMakeRange(loc, len);
            [specials addObject:specol];
            
        }else{
            //普通
            
            str = [[NSAttributedString alloc] initWithString:part.text];
            
        }
        [attri appendAttributedString:str];
    }
    [attri addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attri.length)];
    //将特殊文字及range的数组 绑定到属性文字上，方便主页文字点击颜色处理，见 WBstatusTEXT.m
    [attri addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attri;
}
-(void)setRetweeted_status:(WBstatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    NSString *retweet = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name, retweeted_status.text];
   
   self.retweeted_statusText =  [self AttributedStringText:retweet];

}
-(NSString *)created_at{
    //Fri  Sep 25 17:03:03 +0800 2015
    //EEE  MMM dd HH mm ss  Z    yyyy
    NSDateFormatter *fmDate    = [[NSDateFormatter alloc] init];
    /** 真机调试     */
    fmDate.locale              = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    fmDate.dateFormat          = @"EEE MMM dd HH:mm:ss Z yyyy";

    NSDate *createdDate =[fmDate dateFromString:_created_at];
    NSDate *now                = [NSDate date];
    NSCalendar *calendar       = [NSCalendar currentCalendar];
    NSCalendarUnit unit        = NSCalendarUnitYear |NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    /**
     *  两个日期的差
     */
    NSDateComponents *camps    = [calendar components:unit fromDate:createdDate toDate:now options:0];
//    NSDateComponents *creatCamps = [calendar components:unit fromDate:createdDate];
    if ([self isThisYear:createdDate]) {
        if([self isYestarday:createdDate
            ]){//昨天
    fmDate.dateFormat          = @"昨天 HH:MM";
            return [fmDate stringFromDate:createdDate];
        }else if([self isToday:createdDate]){//今天

            if (camps.hour >= 1) {
                return [NSString stringWithFormat:@" %ld小时前 ",(long)camps.hour];
            }else if(camps.minute >= 1){
                return [NSString stringWithFormat:@" %ld分钟前 ",(long)camps.minute];
            }else {
                return @" 刚刚发布 ";
            }
        }else{
            //今年其他日子
    fmDate.dateFormat          = @"MM-dd HH:mm";
            return [fmDate stringFromDate:createdDate];
        }
    }else{//其他年
    fmDate.dateFormat          = @"yyyy-MM-dd HH:mm";
        return [fmDate stringFromDate:createdDate];
    }
    return _created_at;

}
-(BOOL)isThisYear:(NSDate *)date{
    NSCalendar *calendar       = [NSCalendar currentCalendar];
    NSDateComponents *dataCmps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps  = [calendar components:NSCalendarUnitYear fromDate:[NSDate new]];
    return dataCmps.year       = nowCmps.year;

}
-(BOOL)isYestarday:(NSDate *)date{
    NSDate *now                = [NSDate new];
    NSDateFormatter *fomate    = [[NSDateFormatter alloc] init];
    fomate.dateFormat          = @"yyyy-MM-dd";
    NSString *dateStr          = [fomate stringFromDate:date];
    NSString *nowStr           = [fomate stringFromDate:now];
    date                       = [fomate dateFromString:dateStr];
    now                        = [fomate dateFromString:nowStr];
    NSCalendar *calendar       = [NSCalendar currentCalendar];
    NSCalendarUnit unit        = NSCalendarUnitYear |NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *cmps     = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;



}
-(BOOL)isToday:(NSDate *)date{
    NSDate *now                = [NSDate new];
    NSDateFormatter *fomate    = [[NSDateFormatter alloc] init];
    fomate.dateFormat          = @"yyyy-MM-dd";
    NSString *dateStr          = [fomate stringFromDate:date];
    NSString *nowStr           = [fomate stringFromDate:now];
    return [dateStr isEqualToString:nowStr];

}
//来源于
-(void)setSource:(NSString *)source{
    
    if (source.length) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    } else {
        _source = @"来自新浪微博";
    }
//    _source                    = source;
//    //正则表达式 NSRegularExpression
//
//    //截串
//    NSRange range;
//    range.location             = [source rangeOfString:@">"].location + 1;
//    range.length               = [source rangeOfString:@"</"].location - range.location;
//    NSString *sourceStr        = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
//    _source                    = sourceStr;

}
@end
