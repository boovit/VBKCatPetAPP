//
//  YHChannelUtilTools.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHChannelUtilTools.h"
#import "YHUIUtilMacro.h"

@implementation YHChannelUtilTools
+(void)popMainRootVC
{
    [ApplicationDelegate.mainTabVC.selectedViewController popToRootViewControllerAnimated:NO];
}

+(void)pushScanningVC:(UINavigationController*)navigation
{
    YHScanningVC *vc = [[YHScanningVC alloc] init];
    [navigation pushViewController:vc animated:YES];
}

+(void)pushAddPetInfoVC:(UINavigationController*)navigation delegate:(id)delegate data:(YHPetData*)data
{
    YHAddPetInfoVC *vc = [[YHAddPetInfoVC alloc] initWithPetData:data];
    vc.delegate = delegate;
    [navigation pushViewController:vc animated:YES];
}

+(void)pushPetInfoVC:(NSUInteger)petID navigation:(UINavigationController*)navigation
{
    YHPetInfomationVC *vc = [[YHPetInfomationVC alloc] initWithPetId:petID];
    [navigation pushViewController:vc animated:YES];
}

+(void)pushImmuneHistoryVC:(UINavigationController*)navigation
                  delegate:(id)delegate
                     petID:(NSUInteger)petID
                      type:(NSString*)type
                     title:(NSString*)title
{
    YHPetImmuneHistoryVC *vc = [[YHPetImmuneHistoryVC alloc] initWithPetId:petID type:type title:title];
    vc.delegate = delegate;
    [navigation pushViewController:vc animated:YES];
}

+(void)pushQRCodeVC:(UINavigationController*)navigation code:(NSString*)code poster:(UIImage*)image
{
    YHQRCodeVC *vc = [[YHQRCodeVC alloc] initWithQRCodeString:code posterImage:image];
    [navigation pushViewController:vc animated:YES];
}
@end
