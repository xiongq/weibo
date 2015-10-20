//
//  WBemotionTextView.m
//  weibo
//
//  Created by xiong on 15/10/9.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBemotionTextView.h"
#import "WBemotionModel.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
#import "WBemotionAttchment.h"


@implementation WBemotionTextView
-(void)insertEmotion:(WBemotionModel *)emotion{
    
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
//        self.font = [UIFont systemFontOfSize:22];
    }else if (emotion.png){
        WBemotionAttchment *attach = [WBemotionAttchment new];
        attach.emotion = emotion;
//        NSTextAttachment *attach = [NSTextAttachment new];
        
//        attach.image = [UIImage imageNamed:emotion.png];
        
        CGFloat attachWH = self.font.lineHeight;
//        NSLog(@"%f",self.font.lineHeight);
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
//        NSMutableAttributedString *text = (NSMutableAttributedString *)self.attributedText;
        
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributeText:imageStr settingBloack:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        
//        NSRange rang;
//        rang.location = 0;
//        rang.length = text.length;

//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    }

}
-(NSString*)fulltext{
    NSMutableString *fulltext = [NSMutableString new];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//        NSLog(@"%@",attrs);
        WBemotionAttchment *attch = attrs[@"NSAttachment"];
        if (attch) {
            [fulltext appendString:attch.emotion.chs];
//            NSLog(@"%@----img",attch.emotion.chs);
        }else{
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fulltext appendString:str.string];
        }
    }];
    return fulltext;
}
@end
