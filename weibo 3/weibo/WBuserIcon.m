//
//  WBuserIcon.m
//  weibo
//
//  Created by xiong on 15/9/30.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBuserIcon.h"
#import "WBuser.h"
#import "UIView+Extension.h"
#import  <UIImageView+WebCache.h>

@interface WBuserIcon()
@property (strong, nonatomic) UIImageView *verified;

@end
@implementation WBuserIcon
-(UIImageView *)verified{
    if (!_verified) {
        self.verified = [[UIImageView alloc] init];
        [self addSubview:self.verified];
    }
    return _verified;
}

-(void)setUser:(WBuser *)user{
    //图像
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //加v
  //  NSLog(@"%d",user.verified_type);
    switch (user.verified_type) {
        case WBUserVerifiedPersonal:
            self.verified.hidden = NO;
            self.verified.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case WBUserVerifiedOrgEnterprice:
        case WBUserVerifiedOrgMedia:
        case WBUserVerifiedOrgWebsite:
            self.verified.hidden = NO;
            self.verified.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WBUserVerifiedDaren:
            self.verified.hidden = NO;
            self.verified.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
            
            
        default:
            self.verified.hidden = YES;
            break;
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.verified.size = self.verified.image.size;
    CGFloat scale = 0.5;
    
    self.verified.x = self.width  - self.verified.width  * scale;
    self.verified.y = self.height - self.verified.height * scale;
}
@end
