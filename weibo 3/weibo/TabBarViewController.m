//
//  TabBarViewController.m
//  weibo
//
//  Created by xiong on 15/8/26.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "TabBarViewController.h"
#import "UIView+Extension.h"
#import "WBtabbar.h"
#import "centerMenu.h"
#import "WBNaviga.h"
#import "HomeTableViewController.h"
#import "MessigeTableViewController.h"
#import "DiscoverTableViewController.h"
#import "PositionTableViewController.h"
#import "WBComposeViewController.h"


@interface TabBarViewController ()<WBtabbardelegate>
@property (strong,nonatomic) UITableViewController *vcc;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self addChildVc:vc title:@"首页" image:@"tabbar_home"  selectedImage:@"tabbar_home_selected"];
    MessigeTableViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"messige"];
    [self addChildVc:vc2 title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    DiscoverTableViewController *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"dicover"];;
    [self addChildVc:vc3 title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    PositionTableViewController *vc4 = [storyboard instantiateViewControllerWithIdentifier:@"position"];;
    [self addChildVc:vc4 title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    WBtabbar *tabbar = [[WBtabbar alloc] init];
    tabbar.newdelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
   // self.tabBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];
    //[self setValue:[[WBtabbar alloc] init] forKey:@"tabBar"];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

    // 先给外面传进来的小控制器 包装 一个导航控制器
    WBNaviga *nav = [[WBNaviga alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickPlus:(WBtabbar *)tabbar{
    //testNav *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"plus"];
    WBComposeViewController *vc = [[WBComposeViewController alloc]init];
    WBNaviga *nav = [[WBNaviga alloc] initWithRootViewController:vc];
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    WBNaviga *nav = [storyBoard instantiateViewControllerWithIdentifier:@"click"];
//    WBComposeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"comps"];
    [self presentViewController:nav animated:YES completion:nil];

}
-(void)dealloc{

}

@end
