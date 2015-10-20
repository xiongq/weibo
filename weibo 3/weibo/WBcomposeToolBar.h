//
//  WBcomposeToolBar.h
//  weibo
//
//  Created by xiong on 15/10/3.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WBcomposeToolBarButtonTypeCamera,
    WBcomposeToolBarButtonTypePicture,
    WBcomposeToolBarButtonTypeMention,
    WBcomposeToolBarButtonTypeTrend,
    WBcomposeToolBarButtonTypeEmotion
}WBcomposeToolBarButtonType;

@class WBcomposeToolBar;
@protocol WBcomposeToolBarDelegate <NSObject>
@optional
-(void)composeToolBar:(WBcomposeToolBar *)toolbar didclickButton:(WBcomposeToolBarButtonType) btnType;
@end
@interface WBcomposeToolBar : UIView
@property (weak, nonatomic) id<WBcomposeToolBarDelegate> delegate;
@property (nonatomic, assign) BOOL showKeyboard;
@end
