//
//  MsgUITableViewCell.m
//  weibo
//
//  Created by xiong on 15/9/20.
//  Copyright © 2015年 x. All rights reserved.
//

#import "MsgUITableViewCell.h"
#import "WBstatus.h"
#import "WBuser.h"
#import "WBstatusFrame.h"
#import "WBphoto.h"
#import <UIImageView+WebCache.h>
#import "WBstatusPhotoView.h"
#import "WBuserIcon.h"
#import "WBstatusTEXT.h"

@interface MsgUITableViewCell()
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak)IBOutlet UIView *originalView;
/** 头像 */
@property (nonatomic, weak)IBOutlet WBuserIcon *iconView;
/** 会员图标 */
@property (nonatomic, weak)IBOutlet UIImageView *vipView;
/** 配图 */
//@property (nonatomic, weak)IBOutlet WBstatusPhotoView *photoView;
@property (weak, nonatomic)IBOutlet  WBstatusPhotoView *photoViews;
/** 昵称 */
@property (nonatomic, weak)IBOutlet UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak)IBOutlet UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak)IBOutlet UILabel *sourceLabel;
/** 正文 */
@property (weak, nonatomic) IBOutlet WBstatusTEXT *contentLabel;

/** 转发view*/
@property (nonatomic, weak)IBOutlet UIView *retweetview;
/** 正文+昵称 */
@property (weak, nonatomic) IBOutlet WBstatusTEXT *retweetContentLabel;
//@property (nonatomic, weak)IBOutlet UILabel *retweetContentLabel;
/** 转发配图 */
//@property (nonatomic, weak)IBOutlet WBstatusPhotoView *retweetPhoto;
@property (weak, nonatomic)IBOutlet WBstatusPhotoView *retweetPhotos;
/**  微博工具条*/
@property (weak, nonatomic) IBOutlet UIView *toolBar;
/** 转发按键*/
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
/** 评论按键*/
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 点赞按键*/
@property (weak, nonatomic) IBOutlet UIButton *unlike;
@end
@implementation MsgUITableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStatusFrame:(WBstatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    WBstatus *status = statusFrame.status;
    WBuser *user = status.user;
    self.backgroundColor = [UIColor clearColor];

    
    self.originalView.frame =  statusFrame.originalViewF;

    
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
                                      
    if (user.vip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.contentMode = UIViewContentModeCenter;
        NSString *rbank = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:rbank];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }

    self.nameLabel.text = user.name;
    self.nameLabel.font =  namefont;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.font = timefont;
    self.timeLabel.textColor = [UIColor orangeColor];
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.font = timefont;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.attributedText = status.AttributedStringText;

    self.contentLabel.font = contentFont;
    self.contentLabel.frame = statusFrame.contentLabelF;
    

    if (status.pic_urls.count) {

        self.photoViews.frame = statusFrame.photoViewF;
        
        self.photoViews.photo = status.pic_urls ;
        self.photoViews.hidden = NO;
    }else{
        self.photoViews.hidden = YES;
    }
    
    if (status.retweeted_status) {
        WBstatus *retweeted_status = status.retweeted_status;
      
        self.retweetview.hidden = NO;
        self.retweetview.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
        self.retweetview.frame = statusFrame.retweetviewF;
        
        self.retweetContentLabel.font = reteetcontentFont;

        //self.retweetContentLabel.textColor = []

        self.retweetContentLabel.attributedText = status.retweeted_statusText;;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
            if (retweeted_status.pic_urls.count) {
                self.retweetPhotos.frame = statusFrame.retweetPhotoF;
                
                self.retweetPhotos.photo = retweeted_status.pic_urls;

                self.retweetPhotos.hidden = NO;
                }else{
                    self.retweetPhotos.hidden  = YES;
                }
        
        }else{
            self.retweetview.hidden = YES;
        }
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.backgroundColor = [UIColor whiteColor];
    
    self.retweetBtn.frame = statusFrame.retweetBtnF;
    self.commentBtn.frame = statusFrame.commentBtnF;
    self.unlike.frame = statusFrame.unlikeF;
//    NSString *reetCount = [NSString stringWithFormat:@"%d", status.reposts_count];
//    NSString *comCount = [NSString stringWithFormat:@"%d", status.comments_count];
//    NSString *likeCount = [NSString stringWithFormat:@"%d", status.attitudes_count];
//    [self.retweetBtn setTitle:reetCount forState:UIControlStateNormal];
//    [self.commentBtn setTitle:comCount forState:UIControlStateNormal];
//    [self.unlike setTitle:likeCount forState:UIControlStateNormal];
    /**
     *  设置工具条按键数字
     */
    [self count:status.reposts_count btn:self.retweetBtn title:@"转发"];
     [self count:status.comments_count btn:self.commentBtn title:@"评论"];
     [self count:status.attitudes_count btn:self.unlike title:@"赞"];
    /**
     * 设置分割线位置
     */
        UIImageView *line  = [[UIImageView alloc] init];
        UIImageView *line2  = [[UIImageView alloc] init];
        [self setLineImageName:line x:self.commentBtn.frame.origin.x height:self.commentBtn.frame.size.height];
        [self setLineImageName:line2 x:2*self.commentBtn.frame.origin.x height:self.commentBtn.frame.size.height];


}
/**
 *  按键数字方法
 */
-(void)count:(int)count btn:(UIButton *)btn title:(NSString *)title{
    if (count) {
        if (count  < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        }else{
            double wan = count/10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            }
        
    }
    

    [btn setTitle:title forState:UIControlStateNormal];


}
//设置分割线
-(void)setLineImageName:(UIImageView *)name x:(CGFloat)x height:(CGFloat)height{
    name  = [[UIImageView alloc] init];
    name.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self.toolBar addSubview:name];
    name.frame = CGRectMake(x , 0, 1, height);
}
@end
