//
//  DiscoverTableViewController.m
//  weibo
//
//  Created by xiong on 15/8/26.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "seachBar.h"
#import "test.h"
#import "WBNaviga.h"



@interface DiscoverTableViewController ()

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField *seachbar = [[seachBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-30, 30)];
    self.navigationItem.titleView = seachbar;
    self.automaticallyAdjustsScrollViewInsets= YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discover" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test-%ld",(long)indexPath.row];
    cell.detailTextLabel.text = @"123";
    return cell;
}


@end
