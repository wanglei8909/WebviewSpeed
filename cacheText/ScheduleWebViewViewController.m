//
//  ScheduleWebViewViewController.m
//  H5Test
//
//  Created by wanglei on 2018/2/6.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "ScheduleWebViewViewController.h"
#import "HNWebView.h"
#import "HNWebViewPool.h"

@interface ScheduleWebViewViewController ()<WKNavigationDelegate>

@property (nonatomic, weak) HNWebView *webView;

@end

@implementation ScheduleWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(nextPage)];
    self.navigationItem.rightBarButtonItem = reloadItem;
    
    HNWebView *webView = [[HNWebViewPool sharedInstance] pickWebView];
    webView.owner = self;
    if (!webView) {
        webView = [[HNWebView alloc] init];
    }
    webView.frame = self.view.bounds;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    [[HNWebViewPool sharedInstance] setScheduleStartTime:[[NSDate date] timeIntervalSince1970]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile-test.0606.com.cn/strategy/8a3e9025ea5de341f57b65c5?1=1"]]];
    self.webView = webView;
}

- (void)nextPage{
    ScheduleWebViewViewController *ctrl = [[ScheduleWebViewViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didFinishNavigation:%f",[[NSDate date] timeIntervalSince1970]);
    [[HNWebViewPool sharedInstance] setScheduleEndTime:[[NSDate date] timeIntervalSince1970]];
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
