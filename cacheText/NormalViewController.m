//
//  NormalViewController.m
//  H5Test
//
//  Created by wanglei on 2018/2/6.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "NormalViewController.h"
#import "HNWebView.h"
#import "HNWebViewPool.h"

@interface NormalViewController ()<WKNavigationDelegate>

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //https://mobile-test.0606.com.cn/strategy/8a3e9025ea5de341f57b65c5?1=1
//    https://mobile-test.0606.com.cn/preload.html
    self.view.backgroundColor = [UIColor whiteColor];
    [[HNWebViewPool sharedInstance] setNormalStartTime:[[NSDate date] timeIntervalSince1970]];
    HNWebView *webView = [[HNWebView alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    NSLog(@"viewDidLoad:%f",[[NSDate date] timeIntervalSince1970]);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile-test.0606.com.cn/strategy/8a3e9025ea5de341f57b65c5?1=1"]]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didFinishNavigation:%f",[[NSDate date] timeIntervalSince1970]);
    [[HNWebViewPool sharedInstance] setNormalEndTime:[[NSDate date] timeIntervalSince1970]];
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
