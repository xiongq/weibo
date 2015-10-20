//
//  WBstatusPhoto.m
//  weibo
//
//  Created by xiong on 15/9/29.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBstatusPhoto.h"
#import "WBphoto.h"
#import "UIView+Extension.h"
#import <UIImageView+WebCache.h>

@implementation WBstatusPhoto
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(UIImageView *)gif{
    if (!_gif) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        _gif = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_gif];
    }
    return _gif;
}
-(void)setPhoto:(WBphoto *)photo{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.gif.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gif.x = self.width - self.gif.width;
    self.gif.y = self.height - self.gif.height;
}
@end
