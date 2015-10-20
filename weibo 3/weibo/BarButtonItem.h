//
//  BarButtonItem.h
//  weibo
//
//  Created by xiong on 15/8/29.
//  Copyright (c) 2015年 x. All rights reserved.
//  UIBarButtonItem左右图标和方法设置

#import <UIKit/UIKit.h>

@interface BarButtonItem : UIBarButtonItem
+ (UIBarButtonItem *)testTarget:(id)target action:(SEL)action Image:(NSString *)Image Imagehighlighted: (NSString *)Imagehighlighted;
@end
