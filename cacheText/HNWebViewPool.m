//
//  WebViewManager.m
//  H5Test
//
//  Created by wanglei on 2018/2/6.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "HNWebViewPool.h"
#import "AppDelegate.h"

@interface HNWebViewPool ()

@property (nonatomic, strong) NSMutableArray *availableWebArray;

@end

@implementation HNWebViewPool


+ (instancetype)sharedInstance{
    static HNWebViewPool *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HNWebViewPool alloc]init];
    });
    return sharedManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.normalStartTime = 0.f;
        self.normalEndTime = 0.f;
        self.scheduleStartTime = 0.f;
        self.scheduleEndTime = 0.f;
        
        _normalAvgLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, 180, 25)];
        _normalAvgLabel.backgroundColor = [UIColor cyanColor];
        
        _scheduleAvgLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 145, 180, 25)];
        _scheduleAvgLabel.backgroundColor = [UIColor cyanColor];
        
        _availableWebArray = [[NSMutableArray alloc] initWithCapacity:4];
        [_availableWebArray addObject:[[HNWebView alloc] init]];
        [_availableWebArray addObject:[[HNWebView alloc] init]];
        [_availableWebArray addObject:[[HNWebView alloc] init]];
        [_availableWebArray addObject:[[HNWebView alloc] init]];
        
    }
    return self;
}

- (HNWebView *)pickWebView{
    for (int i = 0; i < self.availableWebArray.count; i ++) {
        HNWebView *webView = [self.availableWebArray objectAtIndex:i];
        if (!webView.owner) {
            return webView;
        }
    }
    return nil;
}

- (void)setNormalEndTime:(CGFloat)normalEndTime{
    _normalEndTime = normalEndTime;
    _normalAvgLabel.text = [NSString stringWithFormat:@"临时创建：%f",(_normalEndTime - _normalStartTime)];
    [[self topViewController].view addSubview:_normalAvgLabel];
}

- (void)setScheduleEndTime:(CGFloat)scheduleEndTime{
    _scheduleEndTime = scheduleEndTime;
    _scheduleAvgLabel.text = [NSString stringWithFormat:@"缓存池：%f",(_scheduleEndTime - _scheduleStartTime)];
    [[self topViewController].view addSubview:_scheduleAvgLabel];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

