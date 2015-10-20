//
//  UIWindow+Extension.m
//  weibo
//
//  Created by xiong on 15/9/18.
//  Copyright © 2015年 x. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TabBarViewController.h"
#import "WBscrollviewViewController.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController{
    NSString *key    = @"CFBundleVersion";
    NSString *lastVersion    = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        TabBarViewController *vc  = [[TabBarViewController alloc] init];
        self.rootViewController = vc;
    }else{
        self.rootViewController = [[WBscrollviewViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


}

@end

