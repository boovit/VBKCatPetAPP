//
//  YHPassportUtility.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/5/16.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHPassportUtility.h"
#import "YHMainNav.h"
#import "YHPassportVC.h"

@implementation YHPassportUtility
+(void)presentPassportFromVC:(UIViewController*)vc
{
    if (![vc.presentedViewController isKindOfClass:[YHPassportVC class]]) {//防止重复present
        YHPassportVC *passportVC = [[YHPassportVC alloc] init];
        YHMainNav *passportNavigation = [[YHMainNav alloc] initWithRootViewController:passportVC];
        [vc presentViewController:passportNavigation animated:YES completion:^{
        }];
    }
}
@end
