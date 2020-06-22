//
//  YHNotificationHelper.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/14.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHNotificationHelper.h"
#import <UIKit/UIKit.h>
#import "NSStringIsEmpty.h"


NSString *const kYHNotificationHelper_token = @"kYHNotificationHelper_token";

@implementation YHNotificationHelper
+(void)clearNotificationBadge
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

+(void)updateDeviceToken:(NSString*)token
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *cacheToken = [ud objectForKey:kYHNotificationHelper_token];
    if (![cacheToken isEqualToString:token] && __isStrNotEmpty(token)) {
        [ud setObject:token forKey:kYHNotificationHelper_token];
        [ud synchronize];
        //TODO:上报新的token
    }
}

+(NSString*)getCacheToken
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:kYHNotificationHelper_token];
    return token;
}
@end
