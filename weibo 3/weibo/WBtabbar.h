//
//  WBtabbar.h
//  weibo
//
//  Created by xiong on 15/9/2.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBtabbar;
@protocol WBtabbardelegate <UITabBarDelegate>
@optional
-(void)clickPlus:(WBtabbar *)tabbar;

@end

@interface WBtabbar : UITabBar
@property(weak,nonatomic) id<WBtabbardelegate>newdelegate;

@end
