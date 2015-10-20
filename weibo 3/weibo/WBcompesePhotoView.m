//
//  WBcompesePhotoView.m
//  weibo
//
//  Created by xiong on 15/10/4.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBcompesePhotoView.h"
#import "UIView+Extension.h"

@implementation WBcompesePhotoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _photo = [NSMutableArray array];
    return self;
}

-(void)addphoto:(UIImage *)photo{
    UIImageView *test = [[UIImageView alloc] init];
    test.image = photo;
    [self addSubview:test];
    [_photo addObject:photo];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        /**
         * 商 Y  |0|0|0|  余 X |0|1|2|
         |1|1|1|       |0|1|2|
         |2|2|2|       |0|1|2|
         */
        //计算x值 maxcol要么是3要么是2，col取余的结果0.1.2
        NSUInteger col = i %maxCol;
        photoView.x = col * (imageMargin  + imageWH);
        //计算y值 maxcol要么是3要么是2，row取商的结果0.1.2
        NSUInteger row = i / maxCol;
        photoView.y = row * (imageMargin  + imageWH);
        
        photoView.width = imageWH;
        photoView.height = imageWH;
        
    }
    
    
}
@end
