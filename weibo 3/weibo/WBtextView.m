//
//  WBtextView.m
//  weibo
//
//  Created by xiong on 15/9/30.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBtextView.h"

@implementation WBtextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)change{
        [self setNeedsDisplay];
   
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];

}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];

}
-(void)drawRect:(CGRect)rect{
    if(self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
//    [self.placeholder drawAtPoint:CGPointMake(8, 5) withAttributes:attrs];
    //提示文字范围
    CGRect placeholderRect = CGRectMake(5, 8, rect.size.width - 10, rect.size.height -16);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];

}

@end
