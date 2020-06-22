//
//  AppDelegate+UI.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/2/28.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "YHMainNav.h"
#import "YHMainTabCtr.h"
#import "YHPetMessageNotifyVC.h"
#import "YHAllPetListVC.h"
#import "YHPetManagerVC.h"
#import "YHScanningVC.h"
#import "YHDesignMacro.h"
#import "UIColor+HexValue.h"

@implementation AppDelegate (UI)
-(void)setupWindowVisible
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    YHMainTabCtr *mainTabCtr = [self setupMainTabController];
    self.mainTabVC = mainTabCtr;
    YHMainNav *mainNav = [[YHMainNav alloc] initWithRootViewController:mainTabCtr];
    self.mainNav = mainNav;
    mainNav.navigationBarHidden = YES;
    self.window.rootViewController = mainNav;
    [self.window makeKeyAndVisible];
}



-(YHMainTabCtr*)setupMainTabController
{
    YHMainTabCtr *mainTabCtr = [[YHMainTabCtr alloc] init];
    NSMutableArray *tabsArray = [NSMutableArray array];
    [tabsArray addObject:[self createPetMessageNotifyVC]];
    [tabsArray addObject:[self createAllPetListVC]];
    [tabsArray addObject:[self createPetManagerVC]];
    [mainTabCtr setViewControllers:tabsArray];
    mainTabCtr.selectedIndex = 0;
    [self setTabBarTitleColor];//设置title颜色
    return mainTabCtr;
}

-(UIViewController*)createPetMessageNotifyVC
{
    YHPetMessageNotifyVC *petMessageNotifyVC = [[YHPetMessageNotifyVC alloc] init];
    YHBaseNavigationController *baseNav = [[YHBaseNavigationController alloc] initWithRootViewController:petMessageNotifyVC];
    baseNav.tabBarItem.image = [[UIImage imageNamed:@"tab_message_nor"]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_message_sel"]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.title = @"消息";
    return baseNav;
}

-(UIViewController*)createAllPetListVC
{
    YHAllPetListVC *allPetListVC = [[YHAllPetListVC alloc] init];
    YHBaseNavigationController *baseNav = [[YHBaseNavigationController alloc] initWithRootViewController:allPetListVC];
    baseNav.tabBarItem.image = [[UIImage imageNamed:@"tab_list_nor"]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_list_sel"]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.title = @"列表";
    return baseNav;
}

-(UIViewController*)createPetManagerVC
{
    YHPetManagerVC *vc = [[YHPetManagerVC alloc] init];
    YHBaseNavigationController *baseNav = [[YHBaseNavigationController alloc] initWithRootViewController:vc];
    baseNav.tabBarItem.image = [[UIImage imageNamed:@"tab_mine_nor"]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_mine_sel"]
                                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.title = @"宠窝";
    return baseNav;
}

-(void)setTabBarTitleColor
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexValue:YHDesignMacroColor_TabItemTitle_Normal],NSFontAttributeName:[UIFont systemFontOfSize:YHDesignMacroFontSize_TabItem_Nor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexValue:YHDesignMacroColor_TabItemTitle_Selected],NSFontAttributeName:[UIFont systemFontOfSize:YHDesignMacroFontSize_TabItem_sel]} forState:UIControlStateSelected];
}
@end
