//
//  seachBar.m
//  weibo
//
//  Created by xiong on 15/8/30.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "seachBar.h"

@implementation seachBar
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *seachbarImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *seachbarLeftImage = [[UIImageView alloc] initWithImage:seachbarImage];
        self.leftView = seachbarLeftImage;
        self.leftViewMode =  UITextFieldViewModeAlways;
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
    }
    return self;
}
+(instancetype)seachbar{
    
    return [[self alloc] init];
}

@end
