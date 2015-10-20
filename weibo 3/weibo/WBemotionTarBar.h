//
//  WBemotionTarBar.h
//  weibo
//
//  Created by xiong on 15/10/5.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WBemotionTarBarTypeNone,
    WBemotionTarBarTypeDefule,
    WBemotionTarBarTypeEmoji,
    WBemotionTarBarTypeLxh
}WBemotionTarBarType;

@class WBemotionTarBar;
@protocol WBemotionTarBarDelegate <NSObject>
@optional
-(void)WBemotion:(WBemotionTarBar *)emotionTarbar emotionType:(WBemotionTarBarType)type;
@end
@interface WBemotionTarBar : UIView
@property (nonatomic, weak)  id<WBemotionTarBarDelegate>delegate;

@end
