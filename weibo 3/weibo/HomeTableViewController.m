//
//  HomeTableViewController.m
//  weibo
//
//  Created by xiong on 15/8/26.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIView+Extension.h"
#import "BarButtonItem.h"
#import "downMenu.h"
#import "centerMenu.h"
#import "test.h"
#import "accountTool.h"
#import "account.h"
#import "WBbutton.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "WBuser.h"
#import "WBstatus.h"
#import "MsgUITableViewCell.h"
#import <MJExtension.h>
#import "WBstatusFrame.h"
#import "WBSQL.h"
#import "MJRefresh.h"

@interface HomeTableViewController ()
@property (strong, nonatomic) UIView *alpha;
/**
 *  array放wbstatus模型，一个wbstatus代表一个微博
 */
@property (strong, nonatomic) NSMutableArray *weiboStatues;
@end

@implementation HomeTableViewController{
    UIView *test2;

}
-(NSMutableArray *)weiboStatues{
    if (!_weiboStatues) {
        self.weiboStatues = [NSMutableArray array];
    }
    return _weiboStatues;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  设置导航栏
     */
    [self naviSetup];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    //获取用户信息
    [self UserInfoSetup];
    //载入微博数据
   // [self friendsWeibo];
    //下拉刷新
    [self RefreshControl];
    
    //上拉刷新
    [self upRefresh];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(UnreadStatusCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
//未读微博
-(void)UnreadStatusCount{
    //https://rm.api.weibo.com/2/remind/unread_count.json
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        account *accnt = [accountTool account];
        NSMutableDictionary *prams = [NSMutableDictionary dictionary];
        prams[@"access_token"] = accnt.access_token;
        prams[@"uid"] = accnt.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSInteger status = [responseObject[@"status"] integerValue];
        
        if (status !=0) {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)status];
            [UIApplication sharedApplication].applicationIconBadgeNumber = status;
        }else{
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];

}
//上拉控件刷新加载更多
-(void)upRefresh{
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}
//下拉控件刷新
-(void)RefreshControl{
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    [self.tableView headerBeginRefreshing];
}
//下拉获取最新微博数据
-(void)loadNewStatus{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        account *accnt = [accountTool account];
        NSMutableDictionary *prams = [NSMutableDictionary dictionary];
        prams[@"access_token"] = accnt.access_token;
    
    WBstatusFrame *first = [self.weiboStatues firstObject];
    if (first) {
        prams[@"since_id"] = first.status.idstr;
    }
    //1.先从数据库中加载
    NSArray *statuss = [WBSQL statusWithParams:prams];
    if (statuss.count) {
        /**
         *  statuss是微博模型-字典-数组，取出每个模型放入数组
         */
        NSArray *dictArry = [WBstatus objectArrayWithKeyValuesArray: statuss];
        //遍历 将微博模型数组 转为 wbStatusFrame数组，设置frame
        NSArray *newFrame  =  [self statusFrameWithStatus:dictArry];
        //插入对应位置
        NSRange range = NSMakeRange(0, newFrame.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.weiboStatues insertObjects:newFrame atIndexes:set];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
        [self newWeiboCount:dictArry.count];
    } else {
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [WBSQL saveStatues:responseObject[@"statuses"]];
        NSArray *dictArry = [WBstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrame  =  [self statusFrameWithStatus:dictArry];
        
        NSRange range = NSMakeRange(0, newFrame.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.weiboStatues insertObjects:newFrame atIndexes:set];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self newWeiboCount:dictArry.count];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败-%@",error);
        [self.tableView headerEndRefreshing];
    }];
    }
}
//将微博模型数组 转为 wbStatusFrame数组，设置frame
- (NSArray *)statusFrameWithStatus:(NSArray  *)statuses{
    NSMutableArray *frame = [NSMutableArray array];
    for (WBstatus *status in statuses) {
        WBstatusFrame *f = [[WBstatusFrame alloc] init];
        f.status = status;
        [frame addObject:f];
    }
    return frame;
}
//加载微博个数横幅
-(void)newWeiboCount:(NSUInteger)count{
    UILabel *newCount = [[UILabel alloc] init];
    newCount.width = self.view.frame.size.width;
    newCount.height = 30;
    newCount.y = 64 - newCount.height;
    newCount.textAlignment = NSTextAlignmentCenter;
    newCount.textColor = [UIColor whiteColor];
    
    newCount.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    if (count == 0)return;
    if (count > 0) {
        newCount.text = [NSString stringWithFormat:@"%lu条微博",(unsigned long)count];
    }
    [self.navigationController.view insertSubview:newCount belowSubview:self.navigationController.navigationBar];
    newCount.hidden = YES;
    
    [UIView animateWithDuration:1.0 animations:^{
        newCount.hidden = NO;

        newCount.transform = CGAffineTransformMakeTranslation(0, 30);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            /**
             *  回到原来位置
             */
        newCount.transform = CGAffineTransformIdentity;
     } completion:^(BOOL finished) {
            [newCount removeFromSuperview];
        }];
    }];
}
//-(void)friendsWeibo{
//    //https://api.weibo.com/2/statuses/friends_timeline.json
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//        account *accnt = [accountTool account];
//        NSMutableDictionary *prams = [NSMutableDictionary dictionary];
//        prams[@"access_token"] = accnt.access_token;
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSArray *dictArry = [WBstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        [self.weiboStatues addObjectsFromArray:dictArry];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"失败-%@",error);
//    }];
//}
//用户信息
-(void)UserInfoSetup{
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    account *accnt = [accountTool account];
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"access_token"] = accnt.access_token;
    prams[@"uid"] = accnt.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        UIButton *titleBnt = (UIButton *)self.navigationItem.titleView;
        WBuser *user = [WBuser objectWithKeyValues: responseObject];
        [titleBnt setTitle:user.name forState:UIControlStateNormal];
        accnt.name = user.name;
        [accountTool saveAccount:accnt];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败-%@",error);
    }];

}
//设置导航左右按键
-(void)naviSetup{
    //self.title = self.navigationController.tabBarItem.title;
    /**
     *  左右按键
     */
    self.navigationItem.leftBarButtonItem = [BarButtonItem testTarget:self action:@selector(back:) Image:@"navigationbar_friendsearch" Imagehighlighted:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [BarButtonItem testTarget:self action:@selector(back:) Image:@"navigationbar_pop" Imagehighlighted:@"navigationbar_pop_highlighted"];
    /**
     导航控制器中间按键，点击显示菜单
     */
    NSString *name = [accountTool account].name;
    WBbutton *titleButton = [[WBbutton alloc] init];
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;//按键放到导航
    [titleButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)back:(UIView *)titleButton{
    downMenu *menu = [downMenu downMenu];
    //menu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
    centerMenu *vc = [[centerMenu alloc] init];
    vc.view.height = 44*3;
    vc.view.width = 100;
    test *vc2 = [[test alloc] init];
    vc2.view.height = 200;
    menu.contentController = vc;
    [menu showFrom:titleButton];

    
}
//上拉加载
-(void)loadMoreStatus{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    account *accnt = [accountTool account];
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"access_token"] = accnt.access_token;
    WBstatusFrame *lastStatus = [self.weiboStatues lastObject];
    if (lastStatus) {
        long long maxID = lastStatus.status.idstr.longLongValue -1;
        prams[@"max_id"] = @(maxID);
    }
    NSArray *statuss = [WBSQL statusWithParams:prams];
    if (statuss.count) {
        NSArray *dictArry = [WBstatus objectArrayWithKeyValuesArray:statuss];
        NSArray *newFrame = [self statusFrameWithStatus:dictArry];
        [self.weiboStatues addObjectsFromArray:newFrame];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:prams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [WBSQL saveStatues:responseObject[@"statuses"]];
        NSArray *dictArry = [WBstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrame = [self statusFrameWithStatus:dictArry];
        [self.weiboStatues addObjectsFromArray:newFrame];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败-%@",error);
        [self.tableView footerEndRefreshing];
    }];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.weiboStatues.count == 0 || self.tableView.tableFooterView.hidden == NO)return;
//        CGFloat offesetY = scrollView.contentOffset.y;
//        CGFloat judgeOffsetY = scrollView.contentSize.height - scrollView.height;
//        //NSLog(@"%f,%f",offesetY, judgeOffsetY);
//        if (offesetY >= judgeOffsetY) {
//            self.tableView.tableFooterView.hidden = NO;
//            [self loadMoreStatus];
//        }
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weiboStatues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgUITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"friendsStatuese" forIndexPath:indexPath];
    cell.statusFrame = self.weiboStatues[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBstatusFrame *frame = self.weiboStatues[indexPath.row];
    return  frame.cellHeight;
}
@end
