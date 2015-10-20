//
//  WBNaviga.m
//  weibo
//
//  Created by xiong on 15/8/27.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "WBNaviga.h"
#import "UIView+Extension.h"
#import "BarButtonItem.h"

@interface WBNaviga ()

@end

@implementation WBNaviga

+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    /**
     *  按键不可以点击时的颜色
     */
//        UIBarButtonItem *disitem = [UIBarButtonItem appearance];
    NSMutableDictionary *distestAttrs = [NSMutableDictionary dictionary];
    distestAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    distestAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:distestAttrs forState:UIControlStateDisabled];
    /**
     *  按键可以点击时的颜色
     */
    NSMutableDictionary *testAttrs = [NSMutableDictionary dictionary];
    testAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    testAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:testAttrs forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{      // NSLog(@"%lu",(unsigned long)self.viewControllers.count);
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        /* 滑动返回修复 */
        self.interactivePopGestureRecognizer.delegate = nil;
        /* 设置导航栏上面的内容 */
        viewController.navigationItem.leftBarButtonItem = [BarButtonItem testTarget:self action:@selector(back) Image:@"navigationbar_back" Imagehighlighted:@"navigationbar_back_highlighted"];

        viewController.navigationItem.rightBarButtonItem = [BarButtonItem testTarget:self action:@selector(more) Image:@"navigationbar_more" Imagehighlighted:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
