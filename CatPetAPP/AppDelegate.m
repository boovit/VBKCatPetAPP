//
//  AppDelegate.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UI.h"
#import "AppDelegate+APNS.h"
#import "AppDelegate+Login.h"
#import "AppDelegate+Notification.h"
#import "AppDelegate+Network.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //监控网络状态
    [self monitorNetworkStatus];
    //注册通知
    [self registerNotification];
    //注册推送通知
    [self registerRemoteNotificationWithLaunchOptions:launchOptions];
    //UI初始化
    [self setupWindowVisible];
    //check登陆
    [self checkLogin];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
