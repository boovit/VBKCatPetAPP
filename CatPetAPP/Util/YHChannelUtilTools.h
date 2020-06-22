//
//  YHChannelUtilTools.h
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YHScanningVC.h"
#import "YHAddPetInfoVC.h"
#import "YHPetImmuneHistoryVC.h"
#import "YHPetInfomationVC.h"
#import "YHQRCodeVC.h"

@interface YHChannelUtilTools : NSObject
+(void)popMainRootVC;
+(void)pushScanningVC:(UINavigationController*)navigation;
+(void)pushAddPetInfoVC:(UINavigationController*)navigation delegate:(id)delegate data:(YHPetData*)data;
+(void)pushPetInfoVC:(NSUInteger)petID navigation:(UINavigationController*)navigation;
+(void)pushImmuneHistoryVC:(UINavigationController*)navigation
                  delegate:(id)delegate
                     petID:(NSUInteger)petID
                      type:(NSString*)type
                     title:(NSString*)title;
+(void)pushQRCodeVC:(UINavigationController*)navigation code:(NSString*)code poster:(UIImage*)image;
@end
