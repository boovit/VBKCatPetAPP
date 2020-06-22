//
//  ShareUtil.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/20.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHShareUtil.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation YHShareUtil
+ (NSString *)appDisplayName;
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString*)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)buildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
}


+(void)showToast:(NSString*)text
{
    UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:keyWindow];
    [keyWindow addSubview:HUD];
    HUD.label.text = text;
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:2.0];
}

+(void)showLoadingOnView:(UIView*)superView
{
    [self showLoadingOnView:superView text:@"请稍等"];
}

+(void)showLoadingOnView:(UIView*)superView text:(NSString*)text
{
    [self hideLoadingOnView:superView];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:superView];
    [superView addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.label.text = text;
    [HUD showAnimated:YES];
}

+(void)hideLoadingOnView:(UIView*)superView
{
    for (UIView *v in [superView subviews]) {
        if ([v isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *HUD = (MBProgressHUD*)v;
            [HUD hideAnimated:YES];
        }
    }
}
@end
