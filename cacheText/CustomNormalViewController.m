//
//  CustomNormalViewController.m
//  cacheText
//
//  Created by wanglei on 2018/2/23.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "CustomNormalViewController.h"
#import <WebKit/WebKit.h>
#import "HNWebViewPool.h"

@interface CustomNormalViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic)  WKWebView* webView;


@end

@implementation CustomNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [[HNWebViewPool sharedInstance] setNormalStartTime:[[NSDate date] timeIntervalSince1970]];
    [self startPlay];
}


- (void)startPlay{
    [self.view addSubview:self.webView];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        NSURL *url = [NSURL URLWithString:@"https://mobile-test.0606.com.cn/strategy/8a3e9025ea5de341f57b65c5?1=1"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
        _webView.navigationDelegate = self;
        [_webView loadRequest:request];
        
    }
    return _webView;
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
