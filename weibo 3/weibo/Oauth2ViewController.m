//
//  Oauth2ViewController.m
//  weibo
//
//  Created by xiong on 15/9/7.
//  Copyright (c) 2015年 x. All rights reserved.
//

#import "Oauth2ViewController.h"
#import "TabBarViewController.h"
#import "WBscrollviewViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "account.h"
#import "accountTool.h"
#import "UIWindow+Extension.h"

@interface Oauth2ViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *hub;
}
@end

@implementation Oauth2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     hub = [[MBProgressHUD alloc] init];
    UIWebView *auth = [[UIWebView alloc] init];
    auth.frame      = self.view.frame;
    auth.delegate   = self;
    [self.view addSubview:auth];
    //https://api.weibo.com/oauth2/authorize
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=977035606&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [auth loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromindex = range.length + range.location;
        NSString *code = [url substringFromIndex:fromindex];
        [self accessTokenWithCode:code];
        //禁止回调地址
        return NO;
    }
    return YES;
}
/**
 *
 必选	类型及范围	说明
 client_id	    true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	    true	string	请求的类型，填写authorization_code
 code	        true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
-(void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = @"977035606";
    params[@"client_secret"] = @"e26c3e1694fa32dad49d70453435bc92";
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code;
    params[@"redirect_uri"]  = @"http://www.baidu.com";
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation * Operation, NSDictionary *responseObject) {
        //返回的账号数据存起来
        account *accunt = [account accountWithDict:responseObject];
        [accountTool saveAccount:accunt];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        /**
         *  切换控制器
         */
        [window switchRootViewController];
            } failure:^(AFHTTPRequestOperation * Operation, NSError * error) {
                NSLog(@"%@", error);
        [hub hide:YES ];
    }];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view addSubview:hub];
    hub.labelText = @"努力加载中";
    [hub show:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hub hide:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   [hub hide:YES];
}
@end
