//
//  AppDelegate.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/27.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNav;
@property (strong, nonatomic) UITabBarController *mainTabVC;
@end

