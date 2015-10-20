//
//  WBscrollviewViewController.m
//  weibo
//
//  Created by xiong on 15/9/4.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "WBscrollviewViewController.h"
#import "UIView+Extension.h"
#import "TabBarViewController.h"
#define WBscrollPageCount 4
@interface WBscrollviewViewController ()<UIScrollViewDelegate>
@end
@implementation WBscrollviewViewController{
    UIPageControl *pageNO1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame         = self.view.bounds;
    /**
     *  contentsize
     *
     *  @param scroll.width 屏幕宽度
     *  @param 0            高度给0或者屏幕高度都可以，不能超过。水平滚动
     */
    scroll.contentSize = CGSizeMake(4*scroll.width, 0);
    [self.view addSubview:scroll];
    /**
     *  创建4个imageview，设置其X位置
     */
    for (int i = 0; i < WBscrollPageCount; i++) {
        UIImageView *page = [[UIImageView alloc] initWithFrame:CGRectMake(i*scroll.width, 0, scroll.width, scroll.height)];
        NSString *name    = [NSString stringWithFormat:@"new_feature_%d",i+1];
        page.image        = [UIImage imageNamed:name];
        [scroll addSubview:page];
        if (i == WBscrollPageCount-1) {
            [self shareBtn:page];
        }
    }
    scroll.delegate      = self;
    scroll.pagingEnabled = YES;//分页
    scroll.bounces       = NO;//取消弹簧
    scroll.showsHorizontalScrollIndicator = NO;
    //分页控件
    UIPageControl *pageNO = [[UIPageControl alloc] init];
    pageNO.numberOfPages  = WBscrollPageCount;
    //选中的颜色
    pageNO.currentPageIndicatorTintColor = [UIColor redColor];
    //未选中的颜色
    pageNO.pageIndicatorTintColor        = [UIColor grayColor];
    //位置
    pageNO.centerX = scroll.width*0.5;
    pageNO.centerY = scroll.height-50;
    pageNO1        = pageNO;
    [self.view addSubview:pageNO];

}
-(void)shareBtn:(UIImageView *)page{
    page.userInteractionEnabled = YES;
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给朋友" forState:UIControlStateNormal ];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.size = CGSizeMake(100, 30);
    shareBtn.centerX = page.width*0.5;
    shareBtn.centerY = page.height*0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [page addSubview:shareBtn];
    
    UIButton *go = [[UIButton alloc] init];
    [go setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [go setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [go setTitle:@"开始weibo" forState:UIControlStateNormal];
    [go addTarget:self action:@selector(toroot) forControlEvents:UIControlEventTouchUpInside];
    go.size = go.currentBackgroundImage.size;
    go.centerX = shareBtn.centerX;
    go.centerY = page.height*0.75;
    go.backgroundColor = [UIColor redColor];
    [page addSubview:go];


}
-(void)shareClick:(UIButton *)page{
    page.selected = !page.isSelected;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算并显示控件的位置
    double page = scrollView.contentOffset.x/scrollView.width;
    

    pageNO1.currentPage = (int)(page + 0.5);
    
}
-(void)toroot{
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
   /* TabBarViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTAB"];
    //[self presentViewController:vc animated:YES completion:nil];
    //vc = [[TabBarViewController alloc] init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];*/
    TabBarViewController *vc = [[TabBarViewController alloc] init];
    window.rootViewController = vc;
       // window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTAB"];





}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
