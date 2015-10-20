//
//  WBstatusPhoto.h
//  weibo
//
//  Created by xiong on 15/9/29.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBphoto;
@interface WBstatusPhoto : UIImageView
@property(strong, nonatomic) WBphoto *photo;
@property(strong, nonatomic) UIImageView *gif;
@end
