//
//  AppDelegate+Network.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/14.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate+Network.h"
#import <AFNetworking.h>

#import "YHNetWorkTools+NetStatus.h"
#import "YHShareUtil.h"

NSString *const NetworkError_tips = @"网络连接已断开";

@implementation AppDelegate (Network)
-(void)monitorNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NetworkChangeError object:nil];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                [YHShareUtil showToast:NetworkError_tips];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NetworkChangeError object:nil];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NetworkChangeMobile object:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NetworkChangeWifi object:nil];
            }
        }
    }];
}
@end
