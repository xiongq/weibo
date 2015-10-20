//
//  WBcompesePhotoView.h
//  weibo
//
//  Created by xiong on 15/10/4.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBcompesePhotoView : UIView
- (void)addphoto:(UIImage *)photo;
@property(strong, nonatomic, readonly) NSMutableArray *photo;
@end
