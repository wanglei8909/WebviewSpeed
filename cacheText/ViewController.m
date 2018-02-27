//
//  ViewController.m
//  cacheText
//
//  Created by wanglei on 2018/2/23.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "ViewController.h"
#import "H5TestViewController.h"
#import "CustomCacheViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createButtonWithIndex:1 withTitle:@"加载main资源webview管理缓存" withAction:@selector(autoCache)];
    [self createButtonWithIndex:3 withTitle:@"自定义拦截webview所有请求" withAction:@selector(customCache)];
//    [self createButtonWithIndex:5 withTitle:@"普通" withAction:@selector(normalView)];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)normalView{
    
}

- (void)autoCache{
    H5TestViewController *ctrl = [[H5TestViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)customCache{
    CustomCacheViewController *ctrl = [[CustomCacheViewController alloc] init];
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


@end
