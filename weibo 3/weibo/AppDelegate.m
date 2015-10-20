//
//  AppDelegate.m
//  weibo
//
//  Created by xiong on 15/8/26.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "AppDelegate.h"
#import "WBscrollviewViewController.h"
#import "TabBarViewController.h"
#import "Oauth2ViewController.h"
#import "account.h"
#import "accountTool.h"
#import "UIWindow+Extension.h"
#import <SDWebImageManager.h>

@interface AppDelegate ()
@property (weak,nonatomic)UITabBarController *vc2;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    account *accont = [accountTool account];
    if (accont) {
        [self.window switchRootViewController];
        }else{
        self.window.rootViewController = [[Oauth2ViewController alloc] init];
        }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//     UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
//        [application endBackgroundTask:task];
//    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    //取消下载
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    //清除缓存的照片
    [mgr.imageCache clearMemory];
}
@end
