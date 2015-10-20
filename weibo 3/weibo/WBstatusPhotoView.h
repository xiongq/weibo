//
//  WBstatusPhotoView.h
//  weibo
//
//  Created by xiong on 15/9/29.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBstatusPhotoView : UIView
@property(strong, nonatomic) NSArray *photo;
+(CGSize)sizeWithCount:(NSUInteger)count;
@end
