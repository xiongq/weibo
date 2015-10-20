//
//  UITextView+Extension.h
//  
//
//  Created by xiong on 15/10/9.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributeText:(NSAttributedString *)text;
- (void)insertAttributeText:(NSAttributedString *)text settingBloack:(void (^)(NSMutableAttributedString *attributedText))settingBloack;
@end
