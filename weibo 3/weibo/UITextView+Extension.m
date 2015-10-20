//
//  UITextView+Extension.m
//  
//
//  Created by xiong on 15/10/9.
//
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributeText:(NSAttributedString *)text settingBloack:(void (^)(NSMutableAttributedString *))settingBloack{
    NSMutableAttributedString *attriText = [NSMutableAttributedString new];
    //将之前的文字拼接（图片和普通文字）
    [attriText appendAttributedString:self.attributedText];
    //loc 是指光标选中的位置
    NSUInteger loc = self.selectedRange.location;
    //将图片拼接到光标位置
//    [attriText insertAttributedString:text atIndex:loc];
    [attriText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    if (settingBloack) {
        settingBloack(attriText);
    }
    self.attributedText = attriText;
    //位置+1的意思是讲光比移动到刚才插入文字或图片的后面
    
    self.selectedRange = NSMakeRange(loc + 1 , 0);

}
-(void)insertAttributeText:(NSAttributedString *)text{

    [self insertAttributeText:text settingBloack:nil];
}
@end
