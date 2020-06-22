//
//  AppDelegate+Notification.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/13.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import "YHNetWorkTools.h"
#import "AppDelegate+Login.h"

@implementation AppDelegate (Notification)
-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLogin:) name:kYHNetWorkToolsNotification_NetError_Login object:nil];
}

-(void)presentLogin:(NSNotification*)notification
{
    [self login];
}
@end
