//
//  CustomCacheViewController.m
//  cacheText
//
//  Created by wanglei on 2018/2/23.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "CustomCacheViewController.h"
#import <WebKit/WebKit.h>
#import "NSURLProtocol+WKWebVIew.h"
#import "HybridNSURLProtocol.h"
#import "CustomNormalViewController.h"
#import "CustomNormalScheduleViewController.h"

@interface CustomCacheViewController ()


@end

@implementation CustomCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自定义拦截webview所有请求";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NSURLProtocol wk_registerScheme:@"http"];
    [NSURLProtocol wk_registerScheme:@"https"];
    [NSURLProtocol registerClass:[HybridNSURLProtocol class]];
    
    [self createButtonWithIndex:0 withTitle:@"普通" withAction:@selector(normalRequestAction)];
    [self createButtonWithIndex:1 withTitle:@"提前初始化webView" withAction:@selector(scheduleWebViewAction)];
}

- (void)normalRequestAction{
    CustomNormalViewController *ctrl = [[CustomNormalViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)scheduleWebViewAction{
    CustomNormalScheduleViewController *ctrl = [[CustomNormalScheduleViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
