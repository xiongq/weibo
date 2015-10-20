//
//  WBstatusPhotoView.m
//  weibo
//
//  Created by xiong on 15/9/29.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBstatusPhotoView.h"
#import "WBphoto.h"
#import "WBstatusPhoto.h"
#import "UIView+Extension.h"

#define HWStatusPhotoWH 93
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)
@implementation WBstatusPhotoView
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;

}
-(void)setPhoto:(NSArray *)photo{
    _photo = photo;
    NSUInteger photoCount = photo.count;
    while (self.subviews.count < photoCount) {
        WBstatusPhoto *photos = [[WBstatusPhoto alloc] init];
        [self addSubview:photos];
    }
    for (int i = 0; i < self.subviews.count; i++) {
        WBstatusPhoto *photos = self.subviews[i];
        if (i < photoCount) {
            photos.photo = photo[i];
            photos.hidden = NO;
        }else{
            photos.hidden = YES;
        }
    }

}
-(void)layoutSubviews{
    [super layoutSubviews];
    /**
     *  最多9张图
     */
   // NSUInteger photoCount = self.photo.count;
    NSUInteger maxCol = HWStatusPhotoMaxCol(self.photo.count);
    for (int i = 0; i < self.photo.count; i++) {
        WBstatusPhoto *photos  = self.subviews[i];
        if (self.photo.count == 1) {
            photos.width = 1.5* HWStatusPhotoWH;
            photos.height = photos.width;
            return;
        }
        /**
         * 商 Y  |0|0|0|  余 X |0|1|2|
                |1|1|1|       |0|1|2|
                |2|2|2|       |0|1|2|
         */
        //计算x值 maxcol要么是3要么是2，col取余的结果0.1.2
        NSUInteger col = i %maxCol;
        photos.x = col * (HWStatusPhotoMargin + HWStatusPhotoWH);
        //计算y值 maxcol要么是3要么是2，row取商的结果0.1.2
        NSUInteger row = i / maxCol;
        photos.y = row * (HWStatusPhotoMargin + HWStatusPhotoWH);
        
        photos.width = HWStatusPhotoWH;
        photos.height = HWStatusPhotoWH;
        
        
    }
    

}
+(CGSize)sizeWithCount:(NSUInteger)count{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat viewWitdh = rect.size.width;
    if (count == 1) {
        return CGSizeMake(viewWitdh, 1.5*HWStatusPhotoWH);
    }
    // 最大列数（一行最多有多少列）
    int maxCols = HWStatusPhotoMaxCol(count);
   
    NSUInteger cols = (count >= maxCols)? maxCols : count;
//    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(viewWitdh, photosH);
    

}
@end
