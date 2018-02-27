//
//  HNWebCache.m
//  cacheText
//
//  Created by wanglei on 2018/2/23.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import "HNWebCache.h"

@interface HNWebCache ()

@end

@implementation HNWebCache



+ (instancetype)sharedInstance{
    static HNWebCache *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HNWebCache alloc]init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *array = @[@"https://content.0606.com.cn/mtest/assets/js/main.e07c797700916d242c99.js",
                           @"https://content.0606.com.cn/mtest/assets/js/vendor.e83b9ce2fab2be4be390.js",
                           @"https://content.0606.com.cn/mtest/assets/js/manifest.f6156c29aa188c7f3e2a.js",
                           @"https://content.0606.com.cn/mtest/assets/js/hntrack_1.0.2.js",
                           @"https://mobile-test.0606.com.cn",
                           @"https://mobile-test.0606.com.cn/strategy/8a3e9025ea5de341f57b65c5?1=1",
                           @"https://mobile-test.0606.com.cn/preLoad.html",
                           @"https://content.0606.com.cn/web/js/polyfill.min.js",
                           @"https://content.0606.com.cn/web/js/vconsole.min.js",
                           @"https://content.0606.com.cn/mtest/assets/css/main.34d66b9975556f58478d9c98097fb402.css",
                           @"https://content.0606.com.cn/mtest/assets/js/hntrack_1.0.0.js",
                           @"https://content.0606.com.cn/mtest/assets/js/manifest.b05e1d5304c39f626d2c.js",
                           @"https://content.0606.com.cn/mtest/assets/js/vendor.fce74eb67ee042a8df46.js",
                           @"https://content.0606.com.cn/mtest/assets/js/main.64cd6fdabd3a0ecbc008.js"
                           ];
        for (NSString *urlString in array) {
            [self loadCacheData:urlString];
        }
    }
    return self;
}

- (void)loadCacheData:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self setObject:data forKey:urlString];
        NSLog(@"%@\n%@\n%@",self,urlString,string);
    }];
    [sessionDataTask resume];
}


@end
