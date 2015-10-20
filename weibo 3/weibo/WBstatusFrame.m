//
//  WBstatusFrame.m
//  weibo
//
//  Created by xiong on 15/9/23.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBstatusFrame.h"
#import "WBuser.h"
#import "WBstatus.h"
#import "WBstatusPhotoView.h"
#define statusCellBoardW 10

@implementation WBstatusFrame
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
    
}
-(void)setStatus:(WBstatus *)status{
    _status = status;
    WBuser *user = status.user;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;

    
    /** 头像 */
    CGFloat iconWH =30;
    CGFloat iconx = 10;
    CGFloat icony = 10;
    self.iconViewF = CGRectMake(iconx, icony, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat namex = CGRectGetMaxX(self.iconViewF) + iconx;
    CGSize nameSize = [self sizeWithText:user.name font:namefont];
    self.nameLabelF = (CGRect){{namex, icony},nameSize};
    
    
    /** 会员图标 */
    if (user.vip) {
        CGFloat vipx = CGRectGetMaxX(self.nameLabelF) + statusCellBoardW;
        CGFloat viph = nameSize.height;
        CGFloat vipw = viph;
        self.vipViewF = CGRectMake(vipx, icony, vipw, viph);
        
    }else{
        
    }
        /** 时间 */
    CGFloat timex = namex;
    CGFloat timey = CGRectGetMaxY(self.nameLabelF) + 5;
    CGSize timesize = [self sizeWithText:status.created_at font:timefont];
    timesize.width += 10;
   
    self.timeLabelF = (CGRect){{timex,timey},timesize};
    /** 来源 */
    CGFloat sourcex = CGRectGetMaxX(self.timeLabelF) + statusCellBoardW;
    CGSize courcesize = [self sizeWithText:status.source font:timefont];
    
    self.sourceLabelF = (CGRect){{sourcex,timey},courcesize};

    /** 正文 */
    CGFloat contentX = iconx;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF) + statusCellBoardW);
    CGFloat contentW = cellW - 2 * statusCellBoardW;
    CGSize contentSize = [status.AttributedStringText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelF  = (CGRect){{contentX, contentY},contentSize};
    
    /** 配图 */
    CGFloat originaViewH = 0;
    if (status.pic_urls.count) {
       
        CGFloat photoX = iconx;
        CGFloat phtoty = CGRectGetMaxY(self.contentLabelF) + statusCellBoardW;
         CGSize originaViewSize = [WBstatusPhotoView sizeWithCount:status.pic_urls.count];
        self.photoViewF = (CGRect){{photoX,phtoty},originaViewSize};
        originaViewH = CGRectGetMaxY(self.photoViewF) + statusCellBoardW;
        
    }else{
        originaViewH = CGRectGetMaxY(self.contentLabelF) + statusCellBoardW;
    
    }
    /** 原创微博整体 */
    self.originalViewF = CGRectMake(0, 0, cellW, originaViewH);
    
    /** 转发微博的整体 */
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        WBstatus *retweeted_status = status.retweeted_status;
//        WBuser *retweeted_status_user =  retweeted_status.user;
       
        /** 正文+昵称 */
//        NSString *retweet = [NSString stringWithFormat:@"%@ : %@",retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [status.retweeted_statusText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;;
        
        self.retweetContentLabelF = (CGRect){{statusCellBoardW, statusCellBoardW}, retweetContentSize};
        /** 转发配图 */
        CGFloat retweetH =0;
            if (retweeted_status.pic_urls.count) {
                                CGFloat retweetPhotoX = statusCellBoardW;
                CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + statusCellBoardW;
                CGSize reteetPhotosSize = [WBstatusPhotoView sizeWithCount:retweeted_status.pic_urls.count];
                self.retweetPhotoF = (CGRect){{retweetPhotoX,retweetPhotoY},reteetPhotosSize};
                retweetH = CGRectGetMaxY(self.retweetPhotoF) + statusCellBoardW;
                }else{
                    retweetH = CGRectGetMaxY(self.retweetContentLabelF) + statusCellBoardW;
            }
       /** 被转发微博整体 */
        CGFloat reteetX = 0;
        CGFloat reteetY = CGRectGetMaxY(self.originalViewF);
        CGFloat reteetW = cellW;
        self.retweetviewF = CGRectMake(reteetX, reteetY, reteetW, retweetH);
        
        toolBarY = CGRectGetMaxY(self.retweetviewF);
       // self.cellHeight = CGRectGetMaxY(self.retweetviewF) ;
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewF);
        /** cell高度*/
      
    }
    self.toolBarF = CGRectMake(0 , toolBarY+1, cellW , 30);
    self.cellHeight = CGRectGetMaxY(self.toolBarF) +5;
    
    CGFloat btnW = cellW/3;
    CGFloat btnH =  self.toolBarF.size.height;
    
    self.retweetBtnF = CGRectMake(0, 0, btnW, btnH);
    self.commentBtnF = CGRectMake(btnW, 0, btnW, btnH);
    self.unlikeF = CGRectMake(2*btnW, 0, btnW, btnH);
  
}

@end
