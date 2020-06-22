//
//  AppDelegate+Login.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate+Login.h"
#import "YHPassportManager.h"
#import "YHPassportUtility.h"
#import "UIViewController+Ext.h"

#import "YHNotificationHelper.h"
#import "NSMutableDictionary+Safe.h"

@implementation AppDelegate (Login)
-(void)login
{
    [YHPassportUtility presentPassportFromVC:self.window.rootViewController];
}

-(void)checkLogin
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic safe_setObject:[YHNotificationHelper getCacheToken] forKey:@"apnstoken"];
    [[YHPassportManager shareInstance] checkLogin:dic];
//    [self login];
}
@end
