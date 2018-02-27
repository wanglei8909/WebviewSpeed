//
//  WebViewManager.h
//  H5Test
//
//  Created by wanglei on 2018/2/6.
//  Copyright © 2018年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNWebView.h"

@interface HNWebViewPool : NSObject

@property (nonatomic, assign) CGFloat normalStartTime;
@property (nonatomic, assign) CGFloat normalEndTime;
@property (nonatomic, strong) UILabel *normalAvgLabel;

@property (nonatomic, assign) CGFloat scheduleStartTime;
@property (nonatomic, assign) CGFloat scheduleEndTime;
@property (nonatomic, strong) UILabel *scheduleAvgLabel;


+ (instancetype)sharedInstance;

- (HNWebView *)pickWebView;


@end
