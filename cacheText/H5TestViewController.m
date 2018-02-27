//
//  ViewController.m
//  H5Test
//
//  Created by wanglei on 2018/2/6.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "H5TestViewController.h"
#import "NormalViewController.h"
#import "ScheduleWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "HNWebViewPool.h"

@interface H5TestViewController ()<WKNavigationDelegate>

@end

@implementation H5TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"加载main资源webview自己管理缓存";
    [self createButtonWithIndex:0 withTitle:@"普通" withAction:@selector(normalRequestAction)];
    [self createButtonWithIndex:1 withTitle:@"提前初始化webView" withAction:@selector(scheduleWebViewAction)];
    [self createButtonWithIndex:3 withTitle:@"加载main资源" withAction:@selector(scheduleWebViewAndLoadMainAction)];
    [self createButtonWithIndex:4 withTitle:@"查看缓存" withAction:@selector(checkData)];
    [self createButtonWithIndex:5 withTitle:@"清除缓存" withAction:@selector(clean)];
}

- (void)normalRequestAction{
    NormalViewController *ctrl = [[NormalViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)scheduleWebViewAction{
    ScheduleWebViewViewController *ctrl = [[ScheduleWebViewViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)scheduleWebViewAndLoadMainAction{
    HNWebView *webView = [[HNWebViewPool sharedInstance] pickWebView];
    webView.frame = CGRectZero;
    webView.navigationDelegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile-test.0606.com.cn/preLoad"]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"loaded:preload.html" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *bottomAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:bottomAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)clean{
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    NSSet *set = [[NSSet alloc] initWithObjects:WKWebsiteDataTypeDiskCache, nil];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"清理完毕" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *bottomAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:bottomAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)checkData{
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:websiteDataTypes completionHandler:^(NSArray<WKWebsiteDataRecord *> * array) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@",array] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *bottomAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:bottomAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
}

- (void)createButtonWithIndex:(NSInteger)index withTitle:(NSString *)title withAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width - 80, 35);
    button.center = CGPointMake(self.view.frame.size.width * 0.5, 220 + index * 45);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    [button setBackgroundColor:[UIColor magentaColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
