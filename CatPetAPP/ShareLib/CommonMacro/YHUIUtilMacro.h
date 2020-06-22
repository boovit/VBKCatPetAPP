//
//  YHUIUtilMacro.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/1.
//  Copyright © 2018年 yaohr. All rights reserved.
//
//  UI宏
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//system size
#define StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NavigtionBarHeight (StatusBarHeight+44)
#define NavHeight (NavigtionBarHeight-StatusBarHeight)
#define TabBarHeight (ApplicationDelegate.mainTabVC.tabBar.height)
#define SINGLE_PIXEL_HEIGHT  ([UIScreen mainScreen].scale>0?(1.0/[UIScreen mainScreen].scale):0.5)

#define YHUIShadowColor [UIColor colorWithWhite:0.0 alpha:0.2]

#define YHScreen_width  [UIScreen mainScreen].bounds.size.width
#define YHScreen_height [UIScreen mainScreen].bounds.size.height
//CGRect
#define MAX_X(view)     (CGRectGetMaxX(view.frame))
#define MIN_X(view)     (CGRectGetMinX(view.frame))

#define MAX_Y(view)     (CGRectGetMaxY(view.frame))
#define MIN_Y(view)     (CGRectGetMinY(view.frame))

#define WIDTH(view)     (CGRectGetWidth(view.frame))
#define HEIGHT(view)    (CGRectGetHeight(view.frame))
