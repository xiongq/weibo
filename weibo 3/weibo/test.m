//
//  test.m
//  weibo
//
//  Created by xiong on 15/8/26.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "test.h"

@interface test ()

@end

@implementation test

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"chuan";
   UIView *alpha = [[UIView alloc] init];
    alpha.frame = self.view.frame;
    alpha.backgroundColor = [UIColor redColor];
    [self.view addSubview:alpha];
    UIImageView *test = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
    test.backgroundColor = [UIColor blackColor];
    test.userInteractionEnabled = YES;
    [alpha addSubview:test];
    /*UIButton *dianji = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [dianji setTitle:@"eee" forState:UIControlStateNormal];
    dianji.backgroundColor = [UIColor redColor];
    [dianji addTarget:self action:@selector(tes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dianji];*/
    
}
- (void)tes{

    UIView *alpha = [[UIView alloc] init];
     alpha.frame = self.view.frame;
     alpha.backgroundColor = [UIColor redColor];
     [self.view addSubview:alpha];
    UITableView *ddd = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, 100, 200)];
    [alpha addSubview:ddd];
     //[self.view addSubview:test];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
