//
//  AppDelegate+APNS.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/9.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate+APNS.h"
#import <UserNotifications/UserNotifications.h>

#import "YHChannelUtilTools.h"
#import "YHNotificationHelper.h"

NSString * const kYH_APNS_common_action = @"kYH_APNS_common_action";
NSString * const kYH_APNS_common_category = @"kYH_APNS_common_category";

@implementation AppDelegate (APNS)
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token is: %@",token);
    [YHNotificationHelper updateDeviceToken:token];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [YHNotificationHelper clearNotificationBadge];
    if ( application.applicationState == UIApplicationStateActive ) {
        // 程序在运行过程中受到推送通知
        NSLog(@"%@",(NSString*)[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    } else {
        //程序为在运行状态受到推送通知
    }
}

#pragma mark - public
- (void)registerRemoteNotificationWithLaunchOptions:(NSDictionary *)launchOptions
{
    [YHNotificationHelper clearNotificationBadge];
    UIUserNotificationType type = UIUserNotificationTypeNone;
    if ([[launchOptions objectForKey:@"badge"] boolValue]) type |= UIUserNotificationTypeBadge;
    if ([[launchOptions objectForKey:@"sound"] boolValue]) type |= UIUserNotificationTypeSound;
    if ([[launchOptions objectForKey:@"alert"] boolValue]) type |= UIUserNotificationTypeAlert;
    
    if (type == UIUserNotificationTypeNone) {
        type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    }
    
    [self registerNewRemoteNotificationWithType:type];
}

#pragma mark - private
- (void)registerNewRemoteNotificationWithType:(UIUserNotificationType)type
{
    if(@available(iOS 10, *)){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(  UNAuthorizationOptionBadge
                                                 | UNAuthorizationOptionSound
                                                 | UNAuthorizationOptionAlert )
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (granted) {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [[UIApplication sharedApplication] registerForRemoteNotifications];
                                      });
                                  }
                              }];
    }else{
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#pragma mark - delegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler __IOS_AVAILABLE(10.0)
{
    [YHNotificationHelper clearNotificationBadge];
    UNNotificationPresentationOptions presentationOptions = UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert;
    completionHandler(presentationOptions);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler __IOS_AVAILABLE(10.0)
{
    [YHNotificationHelper clearNotificationBadge];
    UNNotificationRequest *unNotificationRequest = response.notification.request;
    NSDictionary *userInfo = unNotificationRequest.content.userInfo;
    [self dealWithReceiveNotification:userInfo];
    completionHandler();
}

-(void)dealWithReceiveNotification:(NSDictionary*)userInfo
{
    NSString *worksType = userInfo[@"works_type"];
    NSDictionary *worksItem = userInfo[@"works_item"];
    if ([worksType isEqualToString:@"pet_detail"]) {
        [self gotoPetDetail:worksItem];
    }else if ([worksType isEqualToString:@"pet_record"]){
        [self gotoPetRecord:worksItem];
    }
}

-(void)gotoPetDetail:(NSDictionary*)item
{
    [YHChannelUtilTools popMainRootVC];
    NSNumber *petid = item[@"petID"];
    [YHChannelUtilTools pushPetInfoVC:petid.unsignedIntegerValue navigation:ApplicationDelegate.mainTabVC.selectedViewController];
}

-(void)gotoPetRecord:(NSDictionary*)item
{
    [YHChannelUtilTools popMainRootVC];
    NSNumber *petid = item[@"petID"];
    NSString *type = item[@"type"];
    NSString *title = item[@"title"];
    [YHChannelUtilTools pushImmuneHistoryVC:ApplicationDelegate.mainTabVC.selectedViewController delegate:nil petID:petid.unsignedIntegerValue type:type title:title];
}
@end
